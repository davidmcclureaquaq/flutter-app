import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_notifications_helper.dart';
import 'second_page.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  final notifications = FlutterLocalNotificationsPlugin();
  TextEditingController _controller;
  String notificationString = "null";

  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);

    _controller = TextEditingController();
  }


  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
  );

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView(
      children: <Widget>[
        title('Notifications'),
        RaisedButton(
          child: Text('Show notification'),
          onPressed: () => showOngoingNotification(notifications,
              title: 'Basic Notification', body: 'Sample Message'),
        ),
        RaisedButton(
          child: Text('Replace notification'),
          onPressed: () => showOngoingNotification(notifications,
              title: 'Basic Notification 2', body: 'Sample Message 2'),
        ),
        RaisedButton(
          child: Text('Additional notification'),
          onPressed: () => showOngoingNotification(notifications,
              title: 'Basic Notification', body: 'Sample Message', id: 20),
        ),
        TextField(
          controller: _controller,
          onChanged: (String value){
            notificationString = value;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Custom notification',
          ),
        ),
        RaisedButton(
          child: Text('Custom notification'),
          onPressed: () => showOngoingNotification(notifications,
              title: 'Custom Notification', body: notificationString, id: 30),
        ),
        const SizedBox(height: 32),
        title('Feautures'),
        RaisedButton(
          child: Text('Silent notification'),
          onPressed: () => showSilentNotification(notifications,
              title: 'SilentTitle', body: 'SilentBody', id: 40),
        ),
        const SizedBox(height: 32),
        title('Cancel'),
        RaisedButton(
          child: Text('Cancel all notification'),
          onPressed: notifications.cancelAll,
        ),
      ],
    ),
  );

  Widget title(String text) => Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Text(
      text,
      style: Theme.of(context).textTheme.title,
      textAlign: TextAlign.center,
    ),
  );

}