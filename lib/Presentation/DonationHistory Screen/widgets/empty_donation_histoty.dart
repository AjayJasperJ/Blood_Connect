import 'package:blood_bank_application/Global/colors.dart';
import 'package:flutter/material.dart';

class EmptyDonationHistoty extends StatefulWidget {
  const EmptyDonationHistoty({super.key});

  @override
  State<EmptyDonationHistoty> createState() => _EmptyDonationHistotyState();
}

class _EmptyDonationHistotyState extends State<EmptyDonationHistoty> {
  @override
  Widget build(BuildContext context) {
    return

         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/blood.png',scale: 1.8)),
            Text('Blood Donation History is Empty!.....',style: TextStyle(color: appColor,fontWeight: FontWeight.bold),)
          ],
        );

  }
}
