import 'dart:convert';
import 'package:blood_bank_application/API/EmergencyalertAPI/emergencymodel.dart';
import 'package:blood_bank_application/API/OrganizationAPI/organizationmodel.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class Organizationprovider with ChangeNotifier {
  bool _isLoading = false;
  bool get islOading {
    return _isLoading;
  }

  final bool _loadingSpinner = false;
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

  List<OrganizationModel> _organization = [];
  List<OrganizationModel> get organization {
    return [..._organization];
  }

  Future getAllOrganizationData({required BuildContext context}) async {
    print('View_organiation API running');
    try {
      _isLoading = true;
      final prefs = await SharedPreferences.getInstance();
      var response = await https.get(
        Uri.parse(
            "https://srishticampus.tech/bloodconnect/phpfiles/api/view_organization.php?user_id=${prefs.getString('user_id')}"),
      );
      if (response.statusCode == 200 && json.decode(response.body)['success']) {
        final List<dynamic> extracteddata =
            jsonDecode(response.body)['organization'];
        _organization = extracteddata
            .map((fields) => OrganizationModel(
                organizationId: fields['organization_id'],
                name: fields['name'],
                regNo: fields['reg_no'],
                contactNo: fields['contact_no'],
                email: fields['email'],
                city: fields['city']))
            .toList();

        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar('Request timeout!'));
    }
  }

  void resetOrgProvider() {
    _organization = [];
    notifyListeners();
  }
}
