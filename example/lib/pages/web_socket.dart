import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebSocket extends StatefulWidget {

  @override
  _WebSocketState createState() => _WebSocketState();
}

class _WebSocketState extends State<WebSocket> {
  TextEditingController editingController = new TextEditingController();
  //Connecting laptop to mobile hotspot in order for mobile to access laptop localhost
  //IP below taken from running ipconfig in cmd
  IOWebSocketChannel channel5 = new IOWebSocketChannel.connect('ws://192.168.43.152:9898');
  StreamController<String> streamController = new StreamController.broadcast();   //Add .broadcast here

  @override
  initState() {
    super.initState();
    print("Creating a StreamController..");
    //First subscription
    streamController.stream.listen((data) {
      print("DataReceived1: " + data);
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
    //Second subscription
    streamController.stream.listen((data) {
      print("DataReceived2: " + data);
    }, onDone: () {
      print("Task Done2");
    }, onError: (error) {
      print("Some Error2");
    });

    channel5.stream.asBroadcastStream().listen((data) {
      print("Channel Data Received: " + data);
    }, onDone: () {
      print("channel Done1");
    }, onError: (error) {
      print("Some Error1");
    });

    streamController.add("This a test data");
    print("code controller is here");

  }

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
                      new InputDecoration(labelText: "Send any message "),
                  controller: editingController,
                )),
//                new StreamBuilder(
//                    stream: channel5.stream.asBroadcastStream(),
//                    builder: (contextl, snapshot) {
//                      print("Streambuilder");
//                      return new Padding(
//                        padding: const EdgeInsets.all(20),
//                        child: new Text(snapshot.hasData ? '${snapshot.data}' : ''),
//                      );
//                    })
              ])),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.send),
        onPressed: _sendMyMessage,
      ),
    );
  }
//

  void _sendMyMessage() {
    if (editingController.text.isNotEmpty) {
      streamController.add(editingController.text);
      channel5.sink.add(editingController.text);
    }
  }

//  @override
//  void dispose() {
//    channel.sink.close();
//    channel5.sink.close();
//    super.dispose();
//  }
}
