import 'package:blood_bank_application/API/BloodRequestAPI/bloodrequestprovider.dart';
import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/Presentation/BloodDonation%20Screen/widgets/blood_donation_rquest_card.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BloodDonationRequestPage extends StatefulWidget {
  static const routname = 'blood_request_screen';
  const BloodDonationRequestPage({super.key});

  @override
  State<BloodDonationRequestPage> createState() =>
      _BloodDonationRequestPageState();
}

class _BloodDonationRequestPageState extends State<BloodDonationRequestPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Bloodrequestprovider>(context, listen: false)
          .getAllBloodRequestData(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bloodrequest = Provider.of<Bloodrequestprovider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appColor,
        title: Text(
          'Blood Donation Request',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: displaysize.height * .018,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Updated Requests',
              style: TextStyle(
                  fontSize: displaysize.height * .018,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: bloodrequest.loadingSpinner
                  ? Center(
                      child: CircularProgressIndicator(
                        color: appColor,
                      ),
                    )
                  : bloodrequest.bloodrequest.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/br.png',
                              scale: 1.8,
                            ),
                            Text(
                              'No Blood Requests...!',
                              style: TextStyle(color: appColor),
                            ),
                          ],
                        ))
                      : SizedBox(
                          height: size.height * 0.05,
                          child: ListView.builder(
                            itemCount: bloodrequest.bloodrequest.length,
                            itemBuilder: (context, intex) {
                              return BloodDonationRquestCard(
                                id: bloodrequest.bloodrequest[intex].id,
                                patientName: bloodrequest
                                    .bloodrequest[intex].patientName,
                                contactno: bloodrequest
                                    .bloodrequest[intex].bystanderContactNo,
                                bloodtype:
                                    bloodrequest.bloodrequest[intex].bloodType,
                                bloodUnitsRequired: bloodrequest
                                    .bloodrequest[intex].bloodUnitsRequired,
                                date: bloodrequest
                                    .bloodrequest[intex].requestedDate,
                              );
                            },
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
