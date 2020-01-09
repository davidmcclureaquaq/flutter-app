import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pages/simple_table.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  enablePlatformOverrideForDesktop();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json Table Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meteorite Mobile"),
          actions: <Widget>[
            // overflow menu
            PopupMenuButton<Choice>(
              onSelected: (Choice) {
                print(Choice.title);
                if (Choice.action == "about") {
                  _showPopup(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return choices.skip(0).map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            SimpleTable(),
          ],
        ),
      ),
    );
  }

  void _showPopup(context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Millennium mobile app"),
          content: new Text("Version: 1.0, For more information contact dev@MLP.com"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

class Choice {
  const Choice({ this.title, this.action });
  final String title;
  final String action;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Menu 1', action: "action 1"),
  Choice(title: 'About', action: "about"),

];
