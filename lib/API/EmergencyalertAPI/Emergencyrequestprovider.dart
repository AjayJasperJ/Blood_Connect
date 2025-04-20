import 'dart:convert';
import 'package:blood_bank_application/API/EmergencyalertAPI/emergencymodel.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as https;

class Emergencyrequestprovider with ChangeNotifier {
  bool _loadingSpinner = false;
  bool get loadingSpinner {
    return _loadingSpinner;
  }

  List<EmergencyRequestModel> _emergency = [];
  List<EmergencyRequestModel> get emergency {
    return [..._emergency];
  }

  Future getAllEmergencyRequestData({required BuildContext context}) async {
    print('View_emergency_request API running');
    try {
      _loadingSpinner = true;
      var response = await https.get(
        Uri.parse(
            "https://srishticampus.tech/bloodconnect/phpfiles/api/view_emergency_request.php"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> extractedData =
            json.decode(response.body)['requests'];
        _emergency = extractedData
            .map((fields) => EmergencyRequestModel(
                id: fields['id'],
                patientName: fields['patient_name'],
                mrNo: fields['mr_no'],
                bystanderName: fields['bystander_name'],
                bystanderContactNo: fields['bystander_contact_no'],
                diagnosis: fields['diagnosis'],
                doctorAssigned: fields['doctor_assigned'],
                bloodType: fields['blood_type'],
                bloodUnitsRequired: fields['blood_units_required'],
                priority: fields['priority'],
                requestedDate: fields['requested_date']))
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

  void resetEmereqProvider() {
    _emergency = [];
    notifyListeners();
  }
}
