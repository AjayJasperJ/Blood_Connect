import 'dart:convert';
import 'package:blood_bank_application/API/BloodRequestAPI/bloodrequestmodel.dart';
import 'package:blood_bank_application/API/EmergencyalertAPI/emergencymodel.dart';
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/UI/dashboardscreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class Bloodrequestprovider with ChangeNotifier {
  bool _loadingSpinner = false;
  bool get loadingSpinner {
    return _loadingSpinner;
  }

  bool _isSelect = false;

  bool get isSelect {
    return _isSelect;
  }

  final bool _isError = false;

  bool get isError {
    return _isError;
  }

  List<BloodrequestModel> _bloodrequest = [];
  List<BloodrequestModel> get bloodrequest {
    return [..._bloodrequest];
  }

  Future getAllBloodRequestData({required BuildContext context}) async {
    print('View_blood_request API running');
    try {
      _loadingSpinner = true;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      var response = await https.get(
        Uri.parse(
            "https://srishticampus.tech/bloodconnect/phpfiles/api/view_blood_request.php?donor_id=${prefs.getString('user_id')}"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> extractedData =
            json.decode(response.body)['requests'];
        _bloodrequest = extractedData
            .map((fields) => BloodrequestModel(
                id: fields['id'].toString(),
                patientName: fields['patient_name'].toString(),
                mrNo: fields['mr_no'].toString(),
                bystanderName: fields['bystander_name'].toString(),
                bystanderContactNo: fields['bystander_contact_no'].toString(),
                diagnosis: fields['diagnosis'].toString(),
                doctorAssigned: fields['doctor_assigned'].toString(),
                bloodType: fields['blood_type'].toString(),
                bloodUnitsRequired: fields['blood_units_required'].toString(),
                priority: fields['priority'].toString(),
                requestedDate: fields['requested_date'].toString()))
            .toList();
        _loadingSpinner = false;
        notifyListeners();
      } else {
        _loadingSpinner = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(json.decode(response.body)['message']));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar('Request timeout!'));
    }
  }

  Future<void> donationInterest({
    required String donorId,
    required String requestId,
    required BuildContext context,
  }) async {
    final Uri url = Uri.parse(
      'https://srishticampus.tech/bloodconnect/phpfiles/api/donation_interest.php?donor_id=$donorId&request_id=$requestId',
    );

    try {
      final response = await https.post(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body); // Decode JSON

        if (jsonData['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Request successful!',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );

          // Navigate after a short delay to allow user to see message
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Dashboardscreen()),
            );
          });
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar(jsonData['message']));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar('Request timeout!'));
    }
  }

  String _fcmtoken = '';
  String get fcmtoken => _fcmtoken;

  Future<void> fetchtoken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("my custom toeken $token");
    _fcmtoken = token!;
    notifyListeners();
  }

  void resetbloodreqProvider() {
    _fcmtoken = '';
    _bloodrequest = [];
    notifyListeners();
  }
}
