import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    await Firebase.initializeApp();

    // Request permission (iOS)
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) return;

    // Local notifications setup
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings = InitializationSettings(iOS: initSettingsIOS);
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Notification channel (Android, but define for consistency)
    const channel = AndroidNotificationChannel(
      'estigo_default',
      'Estigo Notifications',
      importance: Importance.high,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Get FCM token and register with backend
    final token = await messaging.getToken();
    if (token != null) await _registerDeviceToken(token);

    // Listen for token refresh
    messaging.onTokenRefresh.listen(_registerDeviceToken);

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

  Future<void> _registerDeviceToken(String token) async {
    try {
      await _client.dio.post('/notifications/register-device', data: {
        'token': token,
        'platform': Platform.isIOS ? 'ios' : 'android',
      });
    } catch (_) {
      // Silently fail — server may not have this endpoint yet
    }
  }

  void _showLocalNotification(RemoteMessage message) {
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
      ),
      payload: message.data['route'],
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    // Deep link handling — data['route'] contains the Go route path
    // This will be handled by the router via a callback
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
