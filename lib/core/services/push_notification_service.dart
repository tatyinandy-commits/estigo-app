import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/api_client.dart';

final pushServiceProvider = Provider<PushNotificationService>((ref) {
  final client = ref.watch(apiClientProvider);
  return PushNotificationService(client);
});

/// Handles Firebase Cloud Messaging + local notifications.
class PushNotificationService {
  final ApiClient _client;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  PushNotificationService(this._client);

  Future<void> initialize() async {
    final messaging = FirebaseMessaging.instance;

    // Request permission (iOS)
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) return;

    // Local notifications setup (not needed on web)
    if (!kIsWeb) {
      const initSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );
      const initSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const initSettings = InitializationSettings(
        iOS: initSettingsIOS,
        android: initSettingsAndroid,
      );
      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTap,
      );

      const channel = AndroidNotificationChannel(
        'estigo_default',
        'Estigo Notifications',
        importance: Importance.high,
      );
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    // Get FCM token — on web requires VAPID key (skip for now)
    if (!kIsWeb) {
      final token = await messaging.getToken();
      if (token != null) await _registerDeviceToken(token, _guessPlatform());

      messaging.onTokenRefresh.listen(
        (t) => _registerDeviceToken(t, _guessPlatform()),
      );
    }

    // Foreground messages → show local notification
    FirebaseMessaging.onMessage.listen(_showLocalNotification);

    // Background/terminated tap → handle navigation
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Check if app was opened from terminated state via notification
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  String _guessPlatform() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.android:
        return 'android';
      default:
        return 'web';
    }
  }

  Future<void> _registerDeviceToken(String token, String platform) async {
    try {
      await _client.dio.post('/notifications/register-device', data: {
        'token': token,
        'platform': platform,
      });
    } catch (_) {
      // Silently fail — server may not have this endpoint yet
    }
  }

  void _showLocalNotification(RemoteMessage message) {
    if (kIsWeb) return; // local notifications not available on web
    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
        android: AndroidNotificationDetails(
          'estigo_default',
          'Estigo Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: message.data['route'],
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    final route = message.data['route'];
    if (route != null && _onRouteTap != null) {
      _onRouteTap!(route);
    }
  }

  void _onNotificationTap(NotificationResponse response) {
    final route = response.payload;
    if (route != null && _onRouteTap != null) {
      _onRouteTap!(route);
    }
  }

  /// Set a callback for notification route navigation.
  void Function(String route)? _onRouteTap;
  void setRouteHandler(void Function(String route) handler) {
    _onRouteTap = handler;
  }
}
