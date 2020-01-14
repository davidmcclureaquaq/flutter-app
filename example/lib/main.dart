import 'dart:io';

import 'package:example/blocs/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/data_grid.dart';
import 'pages/paginated_grid.dart';
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

int _currentIndex = 0;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData.dark()),
      child: MaterialAppWithTheme(),
    );
  }
}

@override
class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Json Table Demo',
        theme: theme.getTheme(),
//      theme: ThemeData(
//        primarySwatch: _colors[_currentIndex],
//      ),
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {

  int _selectedPage = 0;
  final _pageOptions = [
    Text('Json Table'),
    Text('Data Grid'),
    Text('Paginated Grid')
  ];

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meteorite Mobile"),
          bottom: TabBar(
          tabs: <Widget>[
            Tab(
            text: "Json Table",
            ),
            Tab(
              text: "Data Grid",
            ),
            Tab(
              text: "Paginated Grid",
            ),
          ],
          ),
          actions: <Widget>[
            // overflow menu
            PopupMenuButton<Choice>(
              onSelected: (Choice) {
                print("Selected: " + Choice.title);
                print("Current color number: $_currentIndex");

                if (Choice.title == "Light Theme") {
                  _themeChanger.setTheme(ThemeData.light());
                }
                if (Choice.title == "Dark Theme") {
                  _themeChanger.setTheme(ThemeData.dark());
                }
                if (Choice.title == "about") {
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
      ),
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
  Choice(title: 'Light Theme',),
  Choice(title: 'Dark Theme'),
  Choice(title: 'About', action: "about"),

];
