library engine;

import 'http/http.dart';
import 'socket/socket.dart';

class Engine extends Object with ServerEngineMixin {
  SocketEngine socket;

  Engine() {
    socket = new SocketEngine();
  }

  powerUpSockets({String ip, int port}) {
    socket.powerUp();
  }
}
