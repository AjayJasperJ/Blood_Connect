import 'dart:convert';

import 'package:blood_bank_application/API/FirebaseAPI/firebasemessage.dart';
import 'package:blood_bank_application/Global/providers.dart';
import 'package:blood_bank_application/Global/routes.dart';
import 'package:blood_bank_application/Splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late Size displaysize;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage1);
  await initializeNotifications();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    showNotification(message.notification!.title.toString(),
        message.notification!.body.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String title = message.notification!.title ?? "No Title";
    String body = message.notification!.body ?? "No Content";
    print('its frontground');
    Map<String, String> newNotification = {
      'title': title,
      'body': body,
    };
    List<String> notifications = prefs.getStringList('fcm_notifications') ?? [];
    notifications.add(jsonEncode(newNotification));
    await prefs.setStringList('fcm_notifications', notifications);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    displaysize = MediaQuery.of(context).size;
    return MultiProvider(
      providers: multiprovider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.remTextTheme(),
            scaffoldBackgroundColor: Color.fromRGBO(246, 247, 249, 1)),
        home: Splashscreen(),
        routes: customRoutes,
      ),
    );
  }
}
