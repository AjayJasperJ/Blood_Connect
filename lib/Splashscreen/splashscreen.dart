import 'package:animate_do/animate_do.dart';
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/UI/dashboardscreen.dart';
import 'package:blood_bank_application/Global/Images/images.dart';
import 'package:blood_bank_application/OnboardingScreen/onboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    navigatoehome();
  }

  navigatoehome() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    final prefs = await SharedPreferences.getInstance();
    final status = prefs.getBool('status') ?? false; // Default to false

    if (status) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboardscreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => GetstartedScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ZoomIn(
      duration: Duration(milliseconds: 1500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Center(child: Image.asset(applogo, scale: 3)),
          SizedBox(height: 50),
        ],
      ),
    ));
  }
}
