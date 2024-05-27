import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../database/models/Notification.dart';
import '../pageNotificationAdmin.dart';

PreferredSizeWidget buildAppBar({required String info}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white10,
    title: Text(
      info,
      style: const TextStyle(fontSize: 16, color: Color(0xFF3A3737), fontWeight: FontWeight.bold),
    ),
    actions: [
      GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: badges.Badge(
            onTap: () {
              Get.to(const PageNotificationAdmin());
            },
            badgeContent: StreamBuilder(
              stream: NotificationSnapshot.streamData(),
              builder: (context, snapshot) {
                List<NotificationSnapshot> list = [];

                try {
                  list = snapshot.data!;
                }
                catch (error) {
                  list = [];
                }

                int count = 0;
                for (var no in list) {
                  if (no.notification.seen == false) count += 1;
                }

                return Text("$count", style: const TextStyle(color: Colors.white));
              },
            ),
            child: const Icon(Icons.notifications_none, color: Color(0xFF3A3737)),
          ),
        ),
        onTap: () {
          Get.to(const PageNotificationAdmin());
        },
      ),
    ],
  );
}