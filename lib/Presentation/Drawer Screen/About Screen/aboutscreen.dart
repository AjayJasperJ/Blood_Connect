import 'package:blood_bank_application/API/BloodRequestAPI/bloodrequestprovider.dart';
import 'package:blood_bank_application/Global/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Aboutscreen extends StatefulWidget {
  const Aboutscreen({super.key});

  @override
  State<Aboutscreen> createState() => _AboutscreenState();
}

class _AboutscreenState extends State<Aboutscreen> {
  @override
  void initState() {
    super.initState();
    final bloodreqProvider =
        Provider.of<Bloodrequestprovider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloodreqProvider.fetchtoken();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloodreqProvider = Provider.of<Bloodrequestprovider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appColor,
        title: Text(
          'About Us',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Us',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                  'Welcome to Blood Bank Application, a life-saving mobile application designed to connect blood donors with those in urgent need. Our app makes blood donation simple, efficient, and accessible anytime, anywhere.'),
              SizedBox(
                height: size.height * 0.02,
              ),
              GestureDetector(
                onLongPress: () {
                  Clipboard.setData(
                      ClipboardData(text: bloodreqProvider.fcmtoken));
                },
                child: Text('Our Mission',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                  'We believe that every drop of blood can make a difference. Our mission is to:'),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                  '* Create a seamless connection between donors and recipients.'),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text('* Ensure quick access to blood banks and hospitals.'),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text('* Promote voluntary blood donation and raise awareness.'),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Why choose Blood bank Application ?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                  '✅ Easy Registration – Sign up as a donor or request blood within minutes.'),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                  '✅ Real-time Blood Requests – Get notified about urgent donation needs.'),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                  '✅ Nearby Blood Banks & Donors – Find and connect with donors or blood banks near you.'),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                  '✅ Secure & Confidential – Your information is protected with the highest standards.'),
            ],
          ),
        ),
      ),
    );
  }
}
