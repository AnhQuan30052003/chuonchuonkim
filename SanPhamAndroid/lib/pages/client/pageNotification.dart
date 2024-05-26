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

          List<NotificationSnapshot> list = [];

          try {
            list = snapshot.data!;
            list.sort((NotificationSnapshot a, NotificationSnapshot b) =>
                (b.notification.idNoti.compareTo(a.notification.idNoti)));
          } catch (error) {
            list = [];
          }

          return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: list.length,
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index].notification.text),
                      trailing: list[index].notification.seen
                          ? const Text("")
                          : const Icon(Icons.mark_as_unread, color: Colors.redAccent),
                      onTap: () {
                        list[index].notification.seen = true;
                        list[index].update(list[index].notification);
                      },
                    );
                  },
                ),
              ));
        },
      ),
    );
  }
}
