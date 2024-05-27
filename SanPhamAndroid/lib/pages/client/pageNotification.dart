// Quân

import 'package:chuonchuonkim_app/database/models/Notification.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:chuonchuonkim_app/helper/widgetClient.dart';
import 'package:flutter/material.dart';

class PageNotification extends StatelessWidget {
  const PageNotification({super.key});

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

          List<NotificationSnapshot> list = [], listNew = [], listOld = [];

          try {
            list = snapshot.data!;

            for (NotificationSnapshot l in list) {
              if (l.notification.seen) {
                listOld.add(l);
              } else {
                listNew.add(l);
              }
            }

            listNew.sort((NotificationSnapshot a, NotificationSnapshot b) => (b.notification.idNoti.compareTo(a.notification.idNoti)));
            listOld.sort((NotificationSnapshot a, NotificationSnapshot b) => (b.notification.idNoti.compareTo(a.notification.idNoti)));
          } catch (error) {
            list = [];
          }

          double spacePading = 5.0;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: spacePading, right: spacePading),
              child: Column(
                children: [
                  _buildTinTucThongBao(spacePading, "Mới(${listNew.length})"),
                  Column(
                    children: listNew.map(
                      (ns) {
                        return GestureDetector(
                          child: Card(
                            color: Colors.white,
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 35,
                                    child: Icon(Icons.mark_as_unread, color: Colors.grey, size: 40),
                                  ),
                                  space(10, 0),
                                  SizedBox(
                                      height: 50,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(ns.notification.text, style: const TextStyle(color: Colors.black))
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () async {
                            // Chuyển page..
                            ns.notification.seen = true;
                            await ns.update(ns.notification);
                          },
                        );
                      }
                    ).toList(),
                  ),

                  _buildTinTucThongBao(spacePading, "Trước đó(${listOld.length})"),
                  Column(
                    children: listOld.map(
                      (ns) {
                        return GestureDetector(
                          child: Card(
                            color: Colors.black12,
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 35,
                                    child: Icon(Icons.mark_as_unread, color: Colors.white, size: 40),
                                  ),
                                  space(10, 0),
                                  SizedBox(
                                      height: 50,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(ns.notification.text, style: const TextStyle(color: Colors.white))
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () async {
                            // Chuyển page..
                          },
                        );
                      }
                    ).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding _buildTinTucThongBao(double spacePading, String text) {
    return Padding(
      padding: EdgeInsets.only(left: spacePading),
      child: buildInstruction(text: text),
    );
  }
}
