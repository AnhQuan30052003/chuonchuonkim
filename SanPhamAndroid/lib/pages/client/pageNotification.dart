// Quân

import 'package:chuonchuonkim_app/database/models/Notification.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';

class PageNotification extends StatefulWidget {
  const PageNotification({super.key});

  @override
  State<PageNotification> createState() => _PageNotificationState();
}

class _PageNotificationState extends State<PageNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          "Thông báo",
          style: TextStyle(fontSize: 16, color: Color(0xFF3A3737), fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: NotificationSnapshot.streamData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var list = (snapshot.data! ?? []);
          list.sort((NotificationSnapshot a, NotificationSnapshot b) => (b.notification.idNoti.compareTo(a.notification.idNoti)));

          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: list.map(
                (e) => Card(
                  color: e.notification.seen ? Colors.white38 : Colors.lightBlueAccent,
                  child: GestureDetector(
                    child: ListTile(
                      title: Text(e.notification.text),
                    ),
                    onTap: () {
                      e.notification.seen = true;
                      e.update(e.notification);
                    },
                  ),
                )
              ).toList(),
            ),
          );
        },
      ),
    );
  }
}


