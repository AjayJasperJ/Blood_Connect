import 'dart:convert';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String title = message.notification?.title ?? "No Title";
  String body = message.notification?.body ?? "No Content";
  print('its background');
  Map<String, String> newNotification = {
    'title': title,
    'body': body,
  };
  List<String> notifications = prefs.getStringList('fcm_notifications') ?? [];
  notifications.add(jsonEncode(newNotification));
  await prefs.setStringList('fcm_notifications', notifications);
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    if (fcmToken == null) {
      print("Failed to retrieve FCM Token.");
    }
  }
}

Future<void> handleBackgroundMessage1(RemoteMessage message) async {
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String title = message.notification!.title ?? "No Title";
  String body = message.notification!.body ?? "No Content";
  print('its background');
  Map<String, String> newNotification = {
    'title': title,
    'body': body,
  };
  List<String> notifications = prefs.getStringList('fcm_notifications') ?? [];
  notifications.add(jsonEncode(newNotification));
  await prefs.setStringList('fcm_notifications', notifications);
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.high,
    priority: Priority.high,
  );
  const NotificationDetails generalNotificationDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    Random().nextInt(999),
    title,
    body,
    generalNotificationDetails,
  );
}
