library engine;

import 'http/http.dart';
import 'socket/socket.dart';

import 'package:pages/pages.dart' as pagesService;

class Engine extends Object with EngineMixin {
  SocketEngine socket;
  pagesService.Pages pages;

  Engine() {
    socket = new SocketEngine();
    pages = new pagesService.Pages();
  }

  powerUpSockets({String ip, int port}) {
    socket.powerUp();
    pages.socket.powerUp();
  }
}