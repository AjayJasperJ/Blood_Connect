import 'dart:convert';
import 'package:blood_bank_application/API/DonationHistoryAPI/donationhistorymodel.dart';
import 'package:blood_bank_application/API/EmergencyalertAPI/emergencymodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class Donationhistoryprovider with ChangeNotifier {
  bool _loadingSpinner = false;
  bool get loadingSpinner {
    return _loadingSpinner;
  }

  List<DonationHistory> _donation = [];
  List<DonationHistory> get donation {
    return [..._donation];
  }

  Future getAllDonationHistory(
      {required BuildContext context, String? donarId}) async {
    print('View_donation_history API running');
    try {
      _loadingSpinner = true;
      notifyListeners();
      var response = await https.get(
        Uri.parse(
            "https://srishticampus.tech/bloodconnect/phpfiles/api/view_donation_history.php?donor_id=$donarId"),
      );
      if (response.statusCode == 200 && jsonDecode(response.body)['success']) {
        final List<dynamic> extracteddata =
            jsonDecode(response.body)['donation_history'];
        _donation = extracteddata
            .map((fields) => DonationHistory(
                id: fields['id'].toString(),
                requestId: fields['request_id'].toString(),
                status: fields['status'].toString(),
                bloodUnitReceived: fields['blood_unit_received'].toString(),
                updatedTime: fields['updated_time'].toString()))
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

  void resetdonateProvider() {
    _donation = [];
    notifyListeners();
  }
}
