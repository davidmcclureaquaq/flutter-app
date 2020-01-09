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

List<Color> _colors = [ //Get list of colors
  Colors.blue,
  Colors.red,
  Colors.yellow,
  Colors.teal,
  Colors.purple
];
int _currentIndex = 0;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Json Table Demo',
      theme: ThemeData(
        primarySwatch: _colors[_currentIndex],
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
                print("Selected: " + Choice.title);
                print("Current color number: $_currentIndex");

                if (Choice.action == "color") {
                  _showColorPopup(context);
                }
                if (Choice.action == "about") {
                  _showAboutPopup(context);
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

  void _showColorPopup(context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("App Color"),
          content: new Text("Choose from colors below:"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Blue"),
              onPressed: () {
                updateColor(0);
                Navigator.of(context).pop();
                build(context);
              },
            ),
            new FlatButton(
              child: new Text("Red"),
              onPressed: () {
                updateColor(1);
                Navigator.of(context).pop();
                build(context);
              },
            ),
            new FlatButton(
              child: new Text("Yellow"),
              onPressed: () {
                updateColor(2);
                Navigator.of(context).pop();
                build(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showAboutPopup(context){
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

  void updateColor(int value) {
    _currentIndex = value;
  }

}

class Choice {
  const Choice({ this.title, this.action });
  final String title;
  final String action;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'App color', action: "color"),
  Choice(title: 'About', action: "about"),

];
