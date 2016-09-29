part of socket_server;

class SocketClient extends Object with NotifyMixin, ObservableMixin {
  IOWebSocketChannel channel;

  SocketClient(WebSocket client) {
    channel = new IOWebSocketChannel(client);

    channel.stream
        .listen(messageHandler, onError: errorHandler, onDone: finishedHandler);
  }

  messageHandler(String data) async {
    Map detailsFromClient = JSON.decode(data);
    String transaction = detailsFromClient['Transaction'];

    Map details = {'From': 'SocketEngine'};
    if (transaction != null) details['Transaction'] = transaction;

    this.write('MessageReceived', details);

    dispatchEvent(detailsFromClient['Message'], detailsFromClient);

    dispatchEvent(
        'WriteToAllClients', {'from': this, 'details': detailsFromClient});
  }

  void errorHandler(error) {
    dispatchEvent('SocketClientMustBeRemoved', this);
    channel.sink.close();
  }

  void finishedHandler() {
    dispatchEvent('SocketClientMustBeRemoved', this);
    channel.sink.close();
  }

  void write(String message, [Map details]) {
    Map detail = details;
    if (detail == null) {
      detail = new Map();
    }
    detail['Message'] = message;
    channel.sink.add(JSON.encode(detail));
  }
}
