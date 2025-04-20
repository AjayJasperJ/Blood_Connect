import 'dart:convert';

import 'package:blood_bank_application/API/EmergencyalertAPI/emergencymodel.dart';
import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/UI/dashboardscreen.dart';
import 'package:blood_bank_application/Global/Images/images.dart';
import 'package:blood_bank_application/Registeration%20Screens/LoginScreen/widgets/loginfarm.dart';
import 'package:blood_bank_application/Registeration%20Screens/LoginScreen/widgets/dialogie.dart';
import 'package:blood_bank_application/Registeration%20Screens/LoginScreen/widgets/roundbutton.dart';
import 'package:blood_bank_application/API/UserAPI/usermodel.dart';
import 'package:blood_bank_application/API/UserAPI/userprovider.dart';
import 'package:blood_bank_application/Registeration%20Screens/RegisterScreen/UI/registerscreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  bool _passwordVisible = false;
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/login.json',
                width: 150,
                height: 150,
                repeat: false, // Play once
              ),
              SizedBox(height: 10),
              Text(
                'Login Successful!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> loginBloodbank(String email, String password) async {
    print('Login API running');
    const url =
        'https://srishticampus.tech/bloodconnect/phpfiles/api/login.php';
    final token = await FirebaseMessaging.instance.getToken();
    print("my custom toeken $token");
    Map<String, String> body = {
      'email': email.toString().toLowerCase(),
      'password': password.toString(),
      'device_token': token.toString()
    };

    try {
      final response = await https.post(
        Uri.parse(url),
        body: body,
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (jsonData['success'] == true) {
          List user = jsonData['user'];
          if (user.isNotEmpty) {
            UserModel userdata = UserModel.fromJson(user[0]);
            String userId = userdata.id;
            Provider.of<UserProvider>(context, listen: false)
                .setCurrentUserId(userId);

            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('status', userId.isNotEmpty);
            await prefs.setString('user_id', userId);
          }
          _showSuccessDialog(context);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Dashboardscreen()),
              (Route<dynamic> route) => false);
          GlobalAlertDialog.show(context, value: 0, msg: 'Login Successfully!');
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar(jsonData['message']));
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar('Request timeout!'));
    }
  }

  void loginButton() {
    if (emailController.text.trim().isEmpty) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Please enter Email",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else if (passwordController.text.trim().isEmpty) {
      MyCustomAlertDialog().showCustomAlertdialog(
          context: context,
          title: 'Note',
          subtitle: "Please enter Password",
          onTapOkButt: () {
            Navigator.of(context).pop();
          });
    } else {
      loginBloodbank(emailController.text, passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.2),
                  Image.asset(applogo, scale: 4),
                  SizedBox(height: size.height * 0.02),
                  const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  const Text('Enter your email and password to login'),
                  SizedBox(height: size.height * 0.02),

                  // Email Field
                  loginTextField(
                    hintText: 'E-Mail',
                    icon: CupertinoIcons.mail,
                    controller: emailController,
                    validator: (value) {
                      if (emailController.text.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    color: Colors.white.withOpacity(0.6),
                  ),
                  SizedBox(height: size.height * 0.05),

                  // Password Field
                  TextFormField(
                    style: TextStyle(fontSize: 13),
                    controller: passwordController,
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(0.6),
                      filled: true,
                      prefixIcon: Icon(CupertinoIcons.lock, color: appColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: appColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintStyle:
                          const TextStyle(fontSize: 13, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),

                  // Login Button
                  isloading
                      ? CircularProgressIndicator(color: appColor)
                      : LoginButton(
                          title: 'Login',
                          onTap: () {
                            loginButton();
                          },
                        ),
                  SizedBox(height: size.height * 0.02),

                  // Register Navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Registerscreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: appColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
