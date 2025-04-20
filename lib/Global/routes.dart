
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/widgets/emergencyalertdetails.dart';
import 'package:blood_bank_application/Presentation/BloodDonation%20Screen/UI/blood_donation_request.dart';
import 'package:blood_bank_application/Presentation/BloodDonation%20Screen/UI/blood_donationdetailsscreen.dart';
import 'package:blood_bank_application/Presentation/DonationHistory%20Screen/UI/donationhistoryscreen.dart';
import 'package:blood_bank_application/Presentation/Profile%20Screen/UI/profilescreen.dart';
import 'package:flutter/material.dart';


var customRoutes = <String, WidgetBuilder>{

    '/profilescreen':(context)=>Profilescreen(),
            'blood_request_screen':(context)=>BloodDonationRequestPage(),
            'blood_donation_details': (context) {
    String id = ModalRoute.of(context)!.settings.arguments.toString();
    return BloodDonationdetailsscreen(
      id: id,
    );
  },
  'emergency_alert_details': (context) {
    String id = ModalRoute.of(context)!.settings.arguments.toString();
    return Emergencyalertdetails(
      id: id,
    );
  },
  'blood_donation_history':(context)=>Donationhistoryscreen()

};
