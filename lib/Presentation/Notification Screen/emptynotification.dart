import 'dart:convert';

import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Emptynotification extends StatefulWidget {
  const Emptynotification({super.key});

  @override
  State<Emptynotification> createState() => _EmptynotificationState();
}

class _EmptynotificationState extends State<Emptynotification> {
  bool _isloading = false;
  List<Map<String, String>> _notifications = [];
  Future<void> _loadNotifications() async {
    print('Running Noti API');
    setState(() {
      _isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedNotifications =
        prefs.getStringList('fcm_notifications') ?? [];

    setState(() {
      _notifications = storedNotifications
          .map((notif) => Map<String, String>.from(jsonDecode(notif)))
          .toList();
      _isloading = false;
    });
  }

  Future<void> _clearNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('fcm_notifications'); // Remove all notifications
    setState(() {
      _notifications.clear(); // Clear the UI list
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appColor,
        title: Text(
          'Notifications',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _clearNotifications();
              },
              icon: Icon(Icons.delete_outline_rounded))
        ],
      ),
      body: _isloading
          ? Center(child: CircularProgressIndicator(color: appColor))
          : _notifications.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Image.asset('assets/empty.png', scale: 2)),
                    Text(
                      'Empty Notifications !.....',
                      style: TextStyle(
                          color: appColor, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: displaysize.height * .02,
                      horizontal: displaysize.width * .04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Updated notifications',
                          style: TextStyle(fontSize: displaysize.height * .018),
                        ),
                        SizedBox(height: displaysize.height * .01),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _notifications.length,
                          itemBuilder: (context, index) {
                            final Map<String, String> data =
                                _notifications[index];
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: displaysize.width * .04,
                                  vertical: displaysize.height * .015),
                              margin: EdgeInsets.symmetric(
                                  vertical: displaysize.height * .005),
                              width: displaysize.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    displaysize.width * .02),
                                color: purewhite,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.notification_important_rounded,
                                    color: appColor,
                                  ),
                                  SizedBox(width: displaysize.width * .04),

                                  /// ✅ Wrap Column inside Expanded
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['title']!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: appColor,
                                            fontSize: displaysize.height * .016,
                                          ),
                                        ),
                                        Text(
                                          data['body']!,
                                          style: TextStyle(
                                              fontSize: displaysize.height *
                                                  .015), // Optional styling
                                          softWrap:
                                              true, // ✅ Allows text to wrap
                                          maxLines:
                                              5, // ✅ Prevents infinite wrapping
                                          overflow: TextOverflow
                                              .ellipsis, // ✅ Handles too long text gracefully
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
