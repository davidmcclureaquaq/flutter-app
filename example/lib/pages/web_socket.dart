import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebSocket extends StatefulWidget {
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  @override
  _WebSocketState createState() => _WebSocketState();
}

class _WebSocketState extends State<WebSocket> {
  TextEditingController editingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Web Socket"),
      ),
      body: new Padding(
          padding: const EdgeInsets.all(20),
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Form(
                    child: new TextFormField(
                  decoration:
                      new InputDecoration(labelText: "Send any message"),
                  controller: editingController,
                )),
                new StreamBuilder(
                    stream: widget.channel.stream.asBroadcastStream(),
                    builder: (context, snapshot) {
                      return new Padding(
                        padding: const EdgeInsets.all(20),
                        child: new Text(snapshot.hasData ? '${snapshot.data}' : ''),
                      );
                    })
              ])),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.send),
        onPressed: _sendMyMessage,
      ),
    );
  }

  void _sendMyMessage() {
    if (editingController.text.isNotEmpty) {
      widget.channel.sink.add(editingController.text);
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
