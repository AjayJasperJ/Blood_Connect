import 'package:blood_bank_application/Global/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactscreen extends StatefulWidget {
  const Contactscreen({super.key});

  @override
  State<Contactscreen> createState() => _ContactscreenState();
}

class _ContactscreenState extends State<Contactscreen> {
  TextEditingController commentcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void launchEmailSubmission() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'myOwnEmailAddress@gmail.com',
        queryParameters: {
          'subject': 'Default Subject',
          'body': 'Default body'
        });
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: appColor,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Support',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'Let us know your',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'feedback & queries',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  InkWell(
                    onTap: () async {
                      final Uri url = Uri(
                        scheme: 'tel',
                        path: "887 012 0688",
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        print('cannot lanuch this url');
                      }
                    },
                    child: Card(
                      shadowColor: Colors.grey,
                      // height: size.height * 0.048,
                      // width: size.width * 0.90,
                      // decoration: BoxDecoration(
                      //   boxShadow: [
                      //     BoxShadow(
                      //         color: Colors.grey.withOpacity(0.4),
                      //         spreadRadius: 1,
                      //         blurRadius: 1)
                      //   ],
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(5),
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Call us',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Icon(
                              Icons.call,
                              color: appColor,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  InkWell(
                    onTap: launchEmailSubmission,
                    child: Card(
                      // height: size.height * 0.048,
                      // width: size.width * 0.90,
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(5),
                      //   boxShadow: [
                      //     BoxShadow(
                      //         color: Colors.grey.withOpacity(0.4),
                      //         spreadRadius: 1,
                      //         blurRadius: 1)
                      //   ],
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Email us',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            Icon(
                              Icons.email,
                              color: appColor,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  const Text(
                    'Write us',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.002,
                  ),
                  Text(
                    'Enter your message',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 1),
                  //   child: Container(
                  //     height: size.height * 0.05,
                  //     width: size.width * 0.90,
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         border: Border.all(color: Colors.white),
                  //         boxShadow: [
                  //           BoxShadow(
                  //               color: Colors.grey.withOpacity(0.4),
                  //               spreadRadius: 1,
                  //               blurRadius: 1)
                  //         ],
                  //         // color: affnityBottomAppBarBackgroundColor,
                  //         borderRadius: BorderRadius.circular(5)),
                  //     child: Center(
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(left: 20),
                  //         child: TextField(
                  //           keyboardType: TextInputType.text,
                  //           decoration: InputDecoration(
                  //             hintText: "Select subject",
                  //             suffixIcon: Icon(
                  //               Icons.expand_more,
                  //               color: greencolor,
                  //             ),
                  //             hintStyle: const TextStyle(color: Colors.grey),
                  //             border: InputBorder.none,
                  //             focusedBorder: InputBorder.none,
                  //           ),
                  //           style: const TextStyle(color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    height: size.height * 0.1,
                    width: size.width * 0.90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      // color: affnityBottomAppBarBackgroundColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 1)
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: commentcontroller,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: "Write here",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          style: const TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your comments';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SizedBox(
                    height: size.height * 0.047,
                    width: size.width * 0.88,
                    child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(backgroundColor: appColor),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    'assets/new.png',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
