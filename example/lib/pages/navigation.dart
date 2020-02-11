import 'package:flutter/material.dart';

import 'page_transition.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: Navigation(),
  ));
}

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('First Route'),
        ),
        body: ListView(children: <Widget>[
          RaisedButton(
            child: Text('Popup route'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );
            },
          ),
          RaisedButton(
            child: Text('Slide right route'),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: SecondRoute()));
            },
          ),
          RaisedButton(
            child: Text('Slide right with fade route'),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: SecondRoute()));
            },
          ),
          RaisedButton(
            child: Text('Fade route'),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: SecondRoute()));
            },
          ),
          RaisedButton(
            child: Text('Scale route'),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.scale, child: SecondRoute()));
            },
          ),
          RaisedButton(
            child: Text('Nested route'),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: NestedRoute()));
            },
          ),
        ])

//      body: Center(
//        child: RaisedButton(
//          child: Text('First route'),
//          onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => SecondRoute()),
//            );
//          },
//        ),
//      ),
        );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class NestedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nested Route"),
        ),
        body: ListView(children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ThirdRoute()));
            },
            child: Text('Continue'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ]));
  }
}
