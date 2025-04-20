import 'dart:async';

import 'package:blood_bank_application/API/EmergencyalertAPI/Emergencyrequestprovider.dart';
import 'package:blood_bank_application/API/OrganizationAPI/organizationprovider.dart';
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/widgets/organizationwidget.dart';
import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/widgets/dashboradcard.dart';
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/widgets/donarcard.dart';
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/widgets/emergencyreqcard.dart';
import 'package:blood_bank_application/Presentation/Drawer%20Screen/drawer.dart';
import 'package:blood_bank_application/Presentation/BloodDonation%20Screen/UI/blood_donation_request.dart';
import 'package:blood_bank_application/Presentation/DonationHistory%20Screen/UI/donationhistoryscreen.dart';
import 'package:blood_bank_application/Presentation/Notification%20Screen/emptynotification.dart';
import 'package:blood_bank_application/API/UserAPI/userprovider.dart';
import 'package:blood_bank_application/Presentation/Profile%20Screen/UI/profilescreen.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  final PageController _mypagecontroller = PageController();
  int _currentPage = 0;
  @override
  void initState() {
    final user = Provider.of<UserProvider>(context, listen: false);
    Provider.of<Emergencyrequestprovider>(context, listen: false)
        .getAllEmergencyRequestData(context: context);
    Provider.of<Organizationprovider>(context, listen: false)
        .getAllOrganizationData(context: context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      user.getUserData(context: context);
    });

    final emergencyalert =
        Provider.of<Emergencyrequestprovider>(context, listen: false);
    _mypagecontroller.addListener(() {
      setState(() {
        _currentPage = _mypagecontroller.page!.round();
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Timer.periodic(Duration(seconds: 5), (Timer timer) {
        if (_currentPage < emergencyalert.emergency.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        if (_mypagecontroller.hasClients) {
          // Check if attached
          _mypagecontroller.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _mypagecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final emergencyalert = Provider.of<Emergencyrequestprovider>(context);
    final organization = Provider.of<Organizationprovider>(context);
    return SafeArea(
      child: userProvider.donarcardstatus
          ? Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                color: appColor,
              )),
            )
          : Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: appColor,
                title: Text(
                  'Dashboard',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              drawer: DrawerMenu(),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: displaysize.height * .03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: displaysize.width * .04),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/alarm.png',
                                  height: 28,
                                  width: 28,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Emergency Alerts',
                                  style: TextStyle(
                                    color: appColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          emergencyalert.loadingSpinner
                              ? SizedBox(
                                  height: displaysize.height * .25,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: CircularProgressIndicator(
                                          color: appColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : emergencyalert.emergency.isEmpty
                                  ? SizedBox(
                                      height: displaysize.height * .25,
                                      child: Center(
                                          child: Text(
                                        'No Emergency Alerts...',
                                        style: TextStyle(color: appColor),
                                      )),
                                    )
                                  : SizedBox(
                                      height: displaysize.height * .25,
                                      child: PageView.builder(
                                        controller: _mypagecontroller,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            emergencyalert.emergency.length,
                                        itemBuilder: (context, index) {
                                          return EmergencyRequestCard(
                                            id: emergencyalert
                                                .emergency[index].id,
                                            patientName: emergencyalert
                                                .emergency[index].patientName,
                                            contactno: emergencyalert
                                                .emergency[index]
                                                .bystanderContactNo,
                                            bloodrequired: emergencyalert
                                                .emergency[index].bloodType,
                                            bloodUnitsRequired: emergencyalert
                                                .emergency[index]
                                                .bloodUnitsRequired,
                                          );
                                        },
                                      ),
                                    ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: displaysize.width * .04),
                        child: Column(
                          children: [
                            userProvider.donarcardstatus
                                ? SizedBox(
                                    height: displaysize.height * .19,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: appColor,
                                      ),
                                    ),
                                  )
                                : DonarCard(),
                            SizedBox(height: displaysize.height * 0.02),
                            SizedBox(
                              height: displaysize.height * 0.30,
                              child: organization.organization.isEmpty
                                  ? SizedBox(
                                      height: displaysize.height * .25,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/org.png',
                                                height: 50, width: 50),
                                            SizedBox(
                                                height:
                                                    displaysize.height * .01),
                                            Text(
                                              'No Organizations...!',
                                              style: TextStyle(
                                                  color: appColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: organization.organization
                                          .take(3)
                                          .map((org) {
                                        return Organizationwidget(
                                          id: org.organizationId,
                                          name: org.name,
                                          regno: org.regNo,
                                          contact_no: org.contactNo,
                                          email: org.email,
                                          city: org.city,
                                        );
                                      }).toList(),
                                    ),
                            ),
                            SizedBox(height: displaysize.height * .01),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Dashboradcard(
                                      title: 'Notifications',
                                      image: 'assets/notificationicon.png',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Emptynotification()));
                                      }),
                                  Dashboradcard(
                                      title: 'Blood Donation Request',
                                      image: 'assets/bloodicon.png',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const BloodDonationRequestPage()));
                                      }),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Dashboradcard(
                                    title: 'Profile management',
                                    image: 'assets/usericon.png',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Profilescreen()));
                                    }),
                                Dashboradcard(
                                    title: 'Donation History',
                                    image: 'assets/donation.png',
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Donationhistoryscreen()));
                                    })
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
