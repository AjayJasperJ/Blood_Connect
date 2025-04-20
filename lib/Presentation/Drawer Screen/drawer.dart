import 'package:blood_bank_application/API/BloodRequestAPI/bloodrequestprovider.dart';
import 'package:blood_bank_application/API/DonationHistoryAPI/donationhistoryprovider.dart';
import 'package:blood_bank_application/API/EmergencyalertAPI/Emergencyrequestprovider.dart';
import 'package:blood_bank_application/API/EmergencyalertAPI/emergencymodel.dart';
import 'package:blood_bank_application/API/OrganizationAPI/organizationprovider.dart';
import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/Presentation/Drawer%20Screen/About%20Screen/aboutscreen.dart';
import 'package:blood_bank_application/Presentation/BloodDonation%20Screen/UI/blood_donation_request.dart';
import 'package:blood_bank_application/Global/Images/drawericon.dart';
import 'package:blood_bank_application/Registeration%20Screens/LoginScreen/UI/loginscreen.dart';
import 'package:blood_bank_application/Presentation/Notification%20Screen/emptynotification.dart';
import 'package:blood_bank_application/API/UserAPI/userprovider.dart';
import 'package:blood_bank_application/Presentation/Profile%20Screen/UI/profilescreen.dart';
import 'package:blood_bank_application/Presentation/Drawer%20Screen/Contact%20Screen/contactscreen.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.white
            //  gradient: LinearGradient(colors: [Colors.grey, appColor])
            ),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              otherAccountsPicturesSize: const Size(100, 100),
              decoration: BoxDecoration(color: appColor
                  // gradient: LinearGradient(colors: [Colors.grey, appColor])

                  ),
              accountName:
                  Consumer<UserProvider>(builder: (context, value, child) {
                String username = "";
                for (var i = 0; i < value.users.length; i++) {
                  username =
                      "${value.users[i].fullName.substring(0, 1).toUpperCase()}${value.users[i].fullName.substring(1)}";
                }
                return Text(
                  username,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                );
              }),
              currentAccountPicture:
                  Consumer<UserProvider>(builder: (context, value, child) {
                String username = "";
                for (var i = 0; i < value.users.length; i++) {
                  username = value.users[i].avatar;
                }
                return CircleAvatar(
                  backgroundImage: NetworkImage(username),
                );
              }),
              accountEmail:
                  Consumer<UserProvider>(builder: (context, value, child) {
                String username = "";
                for (var i = 0; i < value.users.length; i++) {
                  username = value.users[i].email.toLowerCase();
                }
                return Text(
                  username,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                );
              }),
            ),
            menuList(dprofileicon, 'Profile', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profilescreen()));
            }),
            menuList(bloodreqicon, 'Blood Requirement', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BloodDonationRequestPage()));
            }),
            menuList(aboutusicon, 'About us', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Aboutscreen()));
            }),
            menuList(contactusicon, 'Contact us', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Contactscreen()));
            }),
            menuList(notificationicon, 'Notifications', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Emptynotification()));
            }),
            menuList(blogouticon, 'Logout', () {
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
                                  color: Colors.grey.withOpacity(.1)),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: displaysize.height * .02,
                              left: displaysize.width * .04,
                              right: displaysize.width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Icons.power_settings_new_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text("Are you sure you want to logout?",
                                        style: TextStyle(
                                            fontSize: displaysize.height * .016,
                                            fontWeight: FontWeight.w300)),
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
                                                  .read<Bloodrequestprovider>()
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
                                                  .read<Organizationprovider>()
                                                  .resetOrgProvider();

                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()),
                                                (Route<dynamic> route) => false,
                                              );
                                            },
                                            child: Container(
                                              height: displaysize.height * .045,
                                              width: displaysize.width / 3.5,
                                              decoration: BoxDecoration(
                                                color: appColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        displaysize.width *
                                                            .03),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                                height:
                                                    displaysize.height * .045,
                                                width: displaysize.width / 3.5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            displaysize.width *
                                                                .03),
                                                    border: Border.all(
                                                        color: appColor)),
                                                child: Center(
                                                  child: Text('No',
                                                      style: TextStyle(
                                                          color: appColor)),
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
            }),
          ],
        ),
      ),
    );
  }

  Widget menuList(String image, String title, Function() onTap) {
    return ListTile(
      onTap: onTap,
      leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                image,
                height: 30,
                width: 30,
                color: appColor,
              )),
            ],
          )),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 13),
      ),
    );
  }
}
