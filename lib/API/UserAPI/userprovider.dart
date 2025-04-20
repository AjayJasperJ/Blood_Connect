import 'dart:convert';
import 'package:blood_bank_application/API/UserAPI/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  bool _donarcardstatus = false;
  bool get donarcardstatus {
    return _donarcardstatus;
  }

  List<UserModel> _users = [];
  List<UserModel> get users {
    return [..._users];
  }

  String? currentUserId;
  Future<void> setCurrentUserId(String userId) async {
    currentUserId = userId;
    notifyListeners();
  }

  Future getUserData({BuildContext? context}) async {
    print('view_profile API running');
    try {
      _donarcardstatus = true;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('status')!) {
        final userid = await prefs.getString('user_id');
        currentUserId = userid;
        notifyListeners();
      }
      var response = await https.get(
        Uri.parse(
            "https://srishticampus.tech/bloodconnect/phpfiles/api/view_profile.php?user_id=$currentUserId"),
      );
      if (jsonDecode(response.body)['success'] && response.statusCode == 200) {
        List<dynamic> extracteddata = jsonDecode(response.body)['user'];
        _users = extracteddata
            .map((fields) => UserModel(
                id: fields['id'].toString(),
                email: fields['email'].toString(),
                role: fields['role'].toString(),
                fullName: fields['full_name'].toString(),
                dateOfBirth: fields['date_of_birth'].toString(),
                gender: fields['gender'].toString(),
                bloodGroup: fields['blood_group'].toString(),
                weight: fields['weight'].toString(),
                contactNumber: fields['contact_number'].toString(),
                city: fields['city'].toString(),
                zipCode: fields['zip_code'].toString(),
                healthStatus: fields['health_status'].toString(),
                avatar: fields['avatar'].toString()))
            .toList();
        _donarcardstatus = false;
        notifyListeners();
        print(_users[0].fullName);
      } else {
        _donarcardstatus = true;
        notifyListeners();
      }
    } catch (e) {}
  }

  void resetuserProvider() {
    _users = [];
    notifyListeners();
  }
}
