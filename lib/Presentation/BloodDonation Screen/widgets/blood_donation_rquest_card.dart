import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/Presentation/BloodDonation%20Screen/UI/blood_donationdetailsscreen.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';

class BloodDonationRquestCard extends StatefulWidget {
  final String id;
  final String patientName;
  final String contactno;
  final String bloodtype;
  final String bloodUnitsRequired;
  final String date;
  BloodDonationRquestCard({
    super.key,
    required this.id,
    required this.patientName,
    required this.contactno,
    required this.bloodtype,
    required this.bloodUnitsRequired,
    required this.date,
  });

  @override
  State<BloodDonationRquestCard> createState() =>
      _BloodDonationRquestCardState();
}

class _BloodDonationRquestCardState extends State<BloodDonationRquestCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BloodDonationdetailsscreen(id: widget.id)));
          },
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            //  color: Colors.grey[200],
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: displaysize.height * .02),
                  Row(
                    children: [
                      Icon(Icons.person_outline),
                      SizedBox(width: 5),
                      Text(
                        'Patient Name : ${widget.patientName}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: displaysize.height * .014,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone_android_outlined),
                      SizedBox(width: 5),
                      Text(
                        'Contact No : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: displaysize.height * .015),
                      ),
                      Text(
                        widget.contactno,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: displaysize.height * .015),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.bloodtype_outlined),
                      SizedBox(width: 5),
                      Text(
                        'Blood Type : ${widget.bloodtype}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: displaysize.height * .014,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.add_moderator_outlined),
                      SizedBox(width: 5),
                      Text(
                        'Units Required : ${widget.bloodUnitsRequired}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: displaysize.height * .014,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person_outline),
                      SizedBox(width: 5),
                      Text(
                        'Status : Approved',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: displaysize.height * .014,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: appColor, width: 0.5),
                        color: appColor),
                    child: Row(
                      children: [
                        Container(
                          height: size.height * 0.03,
                          width: size.width * 0.32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            color: Colors.white,
                          ),
                          child: Center(
                              child: Text(
                            'Date and Time',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '${widget.date}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: displaysize.height * .014,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  // Row(
                  //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Card(
                  //       color: Colors.grey,
                  //       child: Padding(
                  //         padding:  EdgeInsets.all(6),
                  //         child: Text(
                  //           'Accept',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: size.width * 0.03,
                  //     ),
                  //     Card(
                  //       color: Colors.grey,
                  //       child: Padding(
                  //         padding:  EdgeInsets.all(6),
                  //         child: Text(
                  //           'Reject',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
