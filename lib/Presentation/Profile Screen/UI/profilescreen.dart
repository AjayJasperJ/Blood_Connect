import 'package:blood_bank_application/API/BloodRequestAPI/bloodrequestprovider.dart';
import 'package:blood_bank_application/API/DonationHistoryAPI/donationhistoryprovider.dart';
import 'package:blood_bank_application/API/EmergencyalertAPI/Emergencyrequestprovider.dart';
import 'package:blood_bank_application/API/EmergencyalertAPI/emergencymodel.dart';
import 'package:blood_bank_application/API/OrganizationAPI/organizationprovider.dart';
import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/Registeration%20Screens/LoginScreen/UI/loginscreen.dart';
import 'package:blood_bank_application/Presentation/Notification%20Screen/emptynotification.dart';
import 'package:blood_bank_application/API/UserAPI/userprovider.dart';
import 'package:blood_bank_application/Presentation/Profile%20Screen/UI/editprofilescreen.dart';
import 'package:blood_bank_application/Presentation/Profile%20Screen/widgets/profilecard.dart';
import 'package:blood_bank_application/Presentation/Profile%20Screen/widgets/subcard.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appColor,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: displaysize.height * .018),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.23,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Column(
                children: [
                  Consumer<UserProvider>(builder: (context, value, child) {
                    String username = "";
                    for (var i = 0; i < value.users.length; i++) {
                      username = value.users[i].avatar;
                    }
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(username),
                    );
                  }),
                  SizedBox(height: size.height * 0.01),
                  Consumer<UserProvider>(builder: (context, value, child) {
                    String username = "";
                    for (var i = 0; i < value.users.length; i++) {
                      username = value.users[i].fullName;
                    }
                    return Center(
                      child: Text(
                        username,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    );
                  }),
                  Consumer<UserProvider>(builder: (context, value, child) {
                    String username = "";
                    for (var i = 0; i < value.users.length; i++) {
                      username = value.users[i].email;
                    }
                    return Center(
                      child: Text(
                        username,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  Card(
                    shadowColor: Colors.grey.withValues(alpha: .5),
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Consumer<UserProvider>(
                            builder: (context, value, child) {
                          String userdob = "";
                          for (var i = 0; i < value.users.length; i++) {
                            userdob = value.users[i].dateOfBirth;
                          }
                          return Profilecard(
                              icon: Icons.calendar_today_outlined,
                              value: 'Date of Birth :',
                              subvalue: userdob);
                        }),
                        Divider(
                          color: Colors.grey[200],
                        ),
                        Consumer<UserProvider>(
                            builder: (context, value, child) {
                          String userdob = "";
                          for (var i = 0; i < value.users.length; i++) {
                            userdob = value.users[i].contactNumber;
                          }
                          return Profilecard(
                              icon: Icons.phone_android_outlined,
                              value: 'Mobile No :',
                              subvalue: userdob);
                        }),
                        Divider(
                          color: Colors.grey[200],
                        ),
                        Consumer<UserProvider>(
                            builder: (context, value, child) {
                          String usergender = "";
                          for (var i = 0; i < value.users.length; i++) {
                            usergender = value.users[i].gender;
                          }
                          return Profilecard(
                              icon: Icons.male_outlined,
                              value: 'Gender :',
                              subvalue: usergender);
                        }),
                        Divider(
                          color: Colors.grey[200],
                        ),
                        Consumer<UserProvider>(
                            builder: (context, value, child) {
                          String userloaction = "";
                          for (var i = 0; i < value.users.length; i++) {
                            userloaction = value.users[i].city;
                          }
                          return Profilecard(
                              icon: Icons.my_location_outlined,
                              value: 'City :',
                              subvalue: userloaction);
                        }),
                        Divider(
                          color: Colors.grey[200],
                        ),
                        Consumer<UserProvider>(
                            builder: (context, value, child) {
                          String userpincode = "";
                          for (var i = 0; i < value.users.length; i++) {
                            userpincode = value.users[i].zipCode;
                          }
                          return Profilecard(
                              icon: Icons.location_on_outlined,
                              value: 'Pincode :',
                              subvalue: userpincode);
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: displaysize.height * .005),
                  ProfileSubcard(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Emptynotification()));
                    },
                  ),
                  SizedBox(height: displaysize.height * .005),
                  ProfileSubcard(
                    icon: Icons.person_add_outlined,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Editprofilescreen(
                                  id: user.currentUserId.toString())));
                    },
                  ),
                  SizedBox(height: displaysize.height * .005),
                  ProfileSubcard(
                    icon: Icons.logout_outlined,
                    title: 'Logout',
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                height: displaysize.height * .25,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(12, 26),
                                          blurRadius: 50,
                                          spreadRadius: 0,
                                          color: Colors.grey.withOpacity(.2)),
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: displaysize.height * .02,
                                      left: displaysize.width * .04,
                                      right: displaysize.width * .04),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Logout",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: appColor,
                                              radius: displaysize.height * .03,
                                              child: Icon(
                                                Icons
                                                    .power_settings_new_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                                "Are you sure you want to logout?",
                                                style: TextStyle(
                                                    fontSize:
                                                        displaysize.height *
                                                            .016,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                    onTap: () async {
                                                      await logoutreset();
                                                      context
                                                          .read<UserProvider>()
                                                          .resetuserProvider();
                                                      context
                                                          .read<
                                                              Bloodrequestprovider>()
                                                          .resetbloodreqProvider();
                                                      context
                                                          .read<
                                                              Donationhistoryprovider>()
                                                          .resetdonateProvider();
                                                      context
                                                          .read<
                                                              Emergencyrequestprovider>()
                                                          .resetEmereqProvider();
                                                      context
                                                          .read<
                                                              Organizationprovider>()
                                                          .resetOrgProvider();

                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginScreen()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false,
                                                      );
                                                    },
                                                    child: Container(
                                                      height:
                                                          displaysize.height *
                                                              .045,
                                                      width: displaysize.width /
                                                          3.5,
                                                      decoration: BoxDecoration(
                                                        color: appColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                displaysize
                                                                        .width *
                                                                    .03),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Yes',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                        height:
                                                            displaysize.height *
                                                                .045,
                                                        width:
                                                            displaysize.width /
                                                                3.5,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    displaysize
                                                                            .width *
                                                                        .03),
                                                            border: Border.all(
                                                                color:
                                                                    appColor)),
                                                        child: Center(
                                                          child: Text('No',
                                                              style: TextStyle(
                                                                  color:
                                                                      appColor)),
                                                        )))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
