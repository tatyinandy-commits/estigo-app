import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/config/env.dart';
import 'package:dio/dio.dart';

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
  final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _timer = Timer.periodic(
        const Duration(seconds: 15), (_) => _checkConnectivity());
  }

  Future<void> _checkConnectivity() async {
    try {
      await _dio.head('${Env.apiBase}/health');
      if (mounted && !_isOnline) {
        setState(() => _isOnline = true);
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
    _dio.close();
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
          child: Center(
            child: Text(
              S.of(context)?.noInternet ?? 'No internet connection',
              style: const TextStyle(
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
