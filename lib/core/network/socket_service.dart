import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  late IO.Socket socket;

  static const String _baseUrl = 'http://192.168.1.44:3000';

  void connect() {
    socket = IO.io(_baseUrl, IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build());

    socket.connect();

    socket.onConnect((_) => print('Socket conectado'));
    socket.onDisconnect((_) => print('Socket desconectado'));
    socket.onConnectError((e) => print('Error conexión: $e'));
  }

  void disconnect() => socket.disconnect();
}