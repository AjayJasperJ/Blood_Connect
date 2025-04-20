import 'package:blood_bank_application/API/DonationHistoryAPI/donationhistoryprovider.dart';
import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/Presentation/DonationHistory%20Screen/widgets/donationhistorycard.dart';
import 'package:blood_bank_application/Presentation/DonationHistory%20Screen/widgets/empty_donation_histoty.dart';
import 'package:blood_bank_application/API/UserAPI/userprovider.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Donationhistoryscreen extends StatefulWidget {
  static const routename = 'blood_donation_history';
  const Donationhistoryscreen({super.key});

  @override
  State<Donationhistoryscreen> createState() => _DonationhistoryscreenState();
}

class _DonationhistoryscreenState extends State<Donationhistoryscreen> {
  @override
  void initState() {
    final donar = Provider.of<UserProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Donationhistoryprovider>(context, listen: false)
          .getAllDonationHistory(
              context: context, donarId: donar.currentUserId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final donation = Provider.of<Donationhistoryprovider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: appColor,
        title: Text(
          'Blood Donation History',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: displaysize.height * .018),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Donation History',
              style: TextStyle(
                  fontSize: displaysize.height * .016,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: donation.loadingSpinner
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            color: appColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  : donation.donation.isEmpty
                      ? EmptyDonationHistoty()
                      : SizedBox(
                          height: size.height * 0.05,
                          child: ListView.builder(
                            itemCount: donation.donation.length,
                            itemBuilder: (context, intex) {
                              return Donationhistorycard(
                                id: donation.donation[intex].id,
                                request_id: donation.donation[intex].requestId,
                                bloodUnitReceived:
                                    donation.donation[intex].bloodUnitReceived,
                                status: donation.donation[intex].status,
                                updatedtime:
                                    donation.donation[intex].updatedTime,
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
