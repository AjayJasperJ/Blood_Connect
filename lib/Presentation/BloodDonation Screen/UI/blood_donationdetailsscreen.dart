import 'package:blood_bank_application/API/BloodRequestAPI/bloodrequestprovider.dart';
import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/API/UserAPI/userprovider.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BloodDonationdetailsscreen extends StatefulWidget {
  static const routeName = 'blood_donation_details';
  final String id;
  BloodDonationdetailsscreen({super.key, required this.id});

  @override
  State<BloodDonationdetailsscreen> createState() =>
      _BloodDonationdetailsscreenState();
}

class _BloodDonationdetailsscreenState
    extends State<BloodDonationdetailsscreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloodrequest = Provider.of<Bloodrequestprovider>(context);
    final user = Provider.of<UserProvider>(context);

    final bloodData = Provider.of<Bloodrequestprovider>(context)
        .bloodrequest
        .firstWhere((element) => element.id == widget.id);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: appColor,
          title: Text(
            'Blood Request Details',
            style: TextStyle(
              fontSize: displaysize.height * .018,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: displaysize.height * .025,
                horizontal: displaysize.width * .02),
            child: Card(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: displaysize.width * .02,
                    vertical: displaysize.height * .02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: displaysize.width * .02),
                        Text(
                          'Details',
                          style: TextStyle(
                              fontSize: displaysize.height * .016,
                              color: appColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Card(
                      color: Colors.grey[300],
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: displaysize.height * .025,
                            horizontal: displaysize.width * .02),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Patient Name',
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          fontWeight: FontWeight.w600),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      ":  ${bloodData.patientName}",
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Mr no',
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          fontWeight: FontWeight.w600),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      ":  ${bloodData.mrNo}",
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'By Stander Name',
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          fontWeight: FontWeight.w600),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      ":  ${bloodData.bystanderName}",
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'By Stander Contact No',
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          fontWeight: FontWeight.w600),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      ":  ${bloodData.bystanderContactNo}",
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: displaysize.height * .01),
                    Card(
                      color: appColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: displaysize.height * .02,
                            horizontal: displaysize.width * .02),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Blood Type',
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      ":  ${bloodData.bloodType}",
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Blood Units Required',
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      ":  ${bloodData.bloodUnitsRequired}",
                                      style: TextStyle(
                                          fontSize: displaysize.height * .014,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: displaysize.height * .025,
                          horizontal: displaysize.width * .02),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Diagnosis',
                                    style: TextStyle(
                                        fontSize: displaysize.height * .014,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    ":  ${bloodData.diagnosis}",
                                    style: TextStyle(
                                        fontSize: displaysize.height * .014,
                                        fontWeight: FontWeight.w600),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Doctor Assigned',
                                    style: TextStyle(
                                        fontSize: displaysize.height * .014,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    ":  ${bloodData.doctorAssigned}",
                                    style: TextStyle(
                                        fontSize: displaysize.height * .014,
                                        fontWeight: FontWeight.w600),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Priority ',
                                    style: TextStyle(
                                        fontSize: displaysize.height * .014,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    ":  ${bloodData.priority}",
                                    style: TextStyle(
                                        fontSize: displaysize.height * .014,
                                        fontWeight: FontWeight.w600),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Requested Date',
                                    style: TextStyle(
                                        fontSize: displaysize.height * .014,
                                        fontWeight: FontWeight.w600),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    ":  ${bloodData.requestedDate}",
                                    style: TextStyle(
                                        fontSize: displaysize.height * .014,
                                        fontWeight: FontWeight.w600),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: appColor),
                                onPressed: () async {
                                  await bloodrequest.donationInterest(
                                      donorId: user.currentUserId.toString(),
                                      requestId: bloodData.id.toString(),
                                      context: context);
                                  print(user.currentUserId.toString());
                                  print(bloodData.id.toString());
                                },
                                child: Text(
                                  'Interest',
                                  style: TextStyle(
                                      fontSize: displaysize.height * .014,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
