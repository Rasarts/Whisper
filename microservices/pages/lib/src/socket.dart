library socket_server;

import 'dart:convert';

import 'package:whisper/whisper.dart' show SocketEngine, SocketClient;

part 'listeners.dart';

class PagesSocket extends SocketEngine with ListenersMixin {
  PagesSocket() {
    prepareEventsListeners();
  }

  @override
  powerUp({String ip, int port: 8182}) {
    super.powerUp(port: port);
  }
}