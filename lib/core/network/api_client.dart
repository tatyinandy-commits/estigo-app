import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../config/env.dart';
import '../storage/secure_storage.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

class ApiClient {
  late final Dio dio;
  bool _isRefreshing = false;
  final List<_QueueItem> _failedQueue = [];

  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: Env.apiBase,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onError: _onError,
    ));
  }

  Future<void> _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SecureStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  Future<void> _onError(
      DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401 &&
        !(error.requestOptions.extra['_retry'] == true)) {
      if (_isRefreshing) {
        // Queue the request
        final completer = Completer<String>();
        _failedQueue.add(_QueueItem(completer));
        try {
          final token = await completer.future;
          error.requestOptions.headers['Authorization'] = 'Bearer $token';
          final response = await dio.fetch(error.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return handler.reject(
            DioException(requestOptions: error.requestOptions, error: e),
          );
        }
      }

      error.requestOptions.extra['_retry'] = true;
      _isRefreshing = true;

      try {
        final refreshDio = Dio(BaseOptions(baseUrl: Env.apiBase));
        final refreshToken = await SecureStorage.getRefreshToken();
        final response = await refreshDio.post(
          '/auth/refresh',
          data: {'refreshToken': refreshToken},
        );

        final newToken =
            response.data['data']['tokens']['accessToken'] as String;
        final newRefresh =
            response.data['data']['tokens']['refreshToken'] as String?;

        await SecureStorage.setAccessToken(newToken);
        if (newRefresh != null) {
          await SecureStorage.setRefreshToken(newRefresh);
        }

        _processQueue(null, newToken);

        error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        final retryResponse = await dio.fetch(error.requestOptions);
        return handler.resolve(retryResponse);
      } catch (refreshError) {
        _processQueue(refreshError, null);
        await SecureStorage.clearAll();
        return handler.reject(
          DioException(
            requestOptions: error.requestOptions,
            error: refreshError,
          ),
        );
      } finally {
        _isRefreshing = false;
      }
    }

    // Capture 5xx in Sentry
    if (error.response != null && error.response!.statusCode! >= 500) {
      Sentry.captureException(error);
    }

    handler.next(error);
  }

  void _processQueue(Object? error, String? token) {
    for (final item in _failedQueue) {
      if (error != null) {
        item.completer.completeError(error);
      } else {
        item.completer.complete(token);
      }
    }
    _failedQueue.clear();
  }
}

class _QueueItem {
  final Completer<String> completer;
  _QueueItem(this.completer);
}
