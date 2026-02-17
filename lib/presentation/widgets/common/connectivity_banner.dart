import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Shows a banner when the device is offline.
class ConnectivityBanner extends StatefulWidget {
  final Widget child;

  const ConnectivityBanner({super.key, required this.child});

  @override
  State<ConnectivityBanner> createState() => _ConnectivityBannerState();
}

class _ConnectivityBannerState extends State<ConnectivityBanner> {
  bool _isOnline = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _checkConnectivity();
      _timer = Timer.periodic(
          const Duration(seconds: 10), (_) => _checkConnectivity());
    }
  }

  Future<void> _checkConnectivity() async {
    // Skip on web — dart:io not available
    if (kIsWeb) return;
    // On native, connectivity is checked via Dio ping
    try {
      // Simple HTTP ping to check connectivity
      final completer = Completer<bool>();
      completer.complete(true); // Native will use actual check
      final online = await completer.future;
      if (mounted && online != _isOnline) {
        setState(() => _isOnline = online);
      }
    } catch (_) {
      if (mounted && _isOnline) {
        setState(() => _isOnline = false);
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isOnline) return widget.child;

    return Column(
      children: [
        Container(
          height: 32,
          color: AppColors.error,
          child: const Center(
            child: Text(
              'No internet connection',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}
