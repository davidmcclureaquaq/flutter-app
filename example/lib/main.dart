import 'dart:io';

import 'package:example/blocs/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'pages/bar_chart.dart';
import 'pages/data_grid.dart';
import 'pages/line_chart.dart';
import 'pages/local_notifications.dart';
import 'pages/paginated_grid.dart';
import 'pages/web_socket.dart';

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
      title: 'Json Table Demo ',
      theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {

  @override
  _RootPage createState() => _RootPage();
}

class _RootPage extends State<RootPage> {
  int _selectedIndex = 0;
  final widgetOptions = [
    //SimpleTable(),
    DataGrid(),
    PaginatedGrid(),
    WebSocket(),
    Notifications(),
    BarChart.withSampleData(),
    LineChart.withSampleData(),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meteorite Mobile "),
          backgroundColor: Colors.black54,
          actions: <Widget>[
            // overflow menu
            PopupMenuButton<Choice>(
              onSelected: (Choice) {
                print("Selected: " + Choice.title);

                if (Choice.title == "Light Theme") {
                  _themeChanger.setTheme(ThemeData.light());
                }
                if (Choice.title == "Dark Theme") {
                  _themeChanger.setTheme(ThemeData.dark());
                }
                if (Choice.title == "About") {
                  _showAboutPopup(context);
                }
                if (Choice.title == "Contact Us") {
                  _showMailPopup(context);
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
        body: Center(
          child: widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
//            BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: Text('Json Table'),
//            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Data Grid'),
              backgroundColor: Colors.black54,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('Paginated Table'),
              backgroundColor: Colors.black54,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed),
              title: Text('Web socket'),
              backgroundColor: Colors.black54,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text('Notifications'),
              backgroundColor: Colors.black54,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              title: Text('Bar Chart'),
              backgroundColor: Colors.black54,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              title: Text('Line Chart'),
              backgroundColor: Colors.black54,
            ),
            ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          onTap: (index) => changeTab(index),
        ),
      ),
    );
  }

  void changeTab(int tabIndex) {
    setState(() {
      _selectedIndex = tabIndex;
    });
  }

  void _showAboutPopup(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Millennium mobile app"),
          content: new Text(
              "Version: 1.0, For more information contact dev@MLP.com"),
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

  void _showMailPopup(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Contact Us"),
          content: new Text(
              "Send mail to dev@MLP.com?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                _launchURL();
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _launchURL() async {
    const url = 'mailto:<email address>?subject=<subject>&body=<body>';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}

class Choice {
  const Choice({this.title, this.action});
  final String title;
  final String action;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Light Theme',),
  Choice(title: 'Dark Theme'),
  Choice(title: 'About', action: "about"),
  Choice(title: 'Contact Us', action: "Contact Us"),
];
