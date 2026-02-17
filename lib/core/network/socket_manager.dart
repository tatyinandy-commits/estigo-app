import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../config/env.dart';
import '../storage/secure_storage.dart';

final socketManagerProvider = Provider<SocketManager>((ref) => SocketManager());

class SocketManager {
  io.Socket? _socket;

  Future<io.Socket> getSocket() async {
    if (_socket != null && _socket!.connected) return _socket!;

    final token = await SecureStorage.getAccessToken();

    _socket = io.io(
      Env.apiUrl,
      io.OptionBuilder()
          .setTransports(['websocket', 'polling'])
          .setAuth({'token': token ?? ''})
          .disableAutoConnect()
          .build(),
    );

    _socket!.connect();
    return _socket!;
  }

  Future<void> joinUser(String userId) async {
    final socket = await getSocket();
    socket.emit('join:user', userId);
  }

  void onP2PUpdate(void Function() callback) {
    _socket?.on('p2p:update', (_) => callback());
  }

  void onP2PTrade(void Function() callback) {
    _socket?.on('p2p:trade', (_) => callback());
  }

  void onNotificationNew(void Function() callback) {
    _socket?.on('notification:new', (_) => callback());
  }

  void onPaymentCompleted(void Function() callback) {
    _socket?.on('payment:completed', (_) => callback());
  }

  void onKycStatusChanged(void Function() callback) {
    _socket?.on('kyc:status-changed', (_) => callback());
  }

  void dispose() {
    _socket?.dispose();
    _socket = null;
  }
}
