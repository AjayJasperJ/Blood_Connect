import 'dart:async';

import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyRequestModel {
  final String id;
  final String patientName;
  final String mrNo;
  final String bystanderName;
  final String bystanderContactNo;
  final String diagnosis;
  final String doctorAssigned;
  final String bloodType;
  final String bloodUnitsRequired;
  final String priority;
  final String requestedDate;

  EmergencyRequestModel(
      {required this.id,
      required this.patientName,
      required this.mrNo,
      required this.bystanderName,
      required this.bystanderContactNo,
      required this.diagnosis,
      required this.doctorAssigned,
      required this.bloodType,
      required this.bloodUnitsRequired,
      required this.priority,
      required this.requestedDate});

  factory EmergencyRequestModel.fromJson(Map<String, dynamic> json) {
    return EmergencyRequestModel(
      id: json['id'],
      patientName: json['patient_name'],
      mrNo: json['mr_no'],
      bystanderName: json['bystander_name'],
      bystanderContactNo: json['bystander_contact_no'],
      diagnosis: json['diagnosis'],
      doctorAssigned: json['doctor_assigned'],
      bloodType: json['blood_type'],
      bloodUnitsRequired: json['blood_units_required'],
      priority: json['priority'],
      requestedDate: json['requested_date'],
    );
  }
}

class GlobalAlertDialog {
  static void show(BuildContext context,
      {required int value, required String msg}) {
    final Completer<void> dialogCompleter = Completer<void>();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        // Wait for 3 seconds, then close the dialog safely
        Future.delayed(Duration(seconds: 3), () {
          if (!dialogCompleter.isCompleted && context.mounted) {
            Navigator.pop(context);
            dialogCompleter.complete(); // Mark as completed
          }
        });

        final List<Map<String, dynamic>> dialogdata = [
          {'gif': 'assets/lottie/animation1.json', 'color': Colors.white},
          {'gif': 'assets/lottie/animation2.json', 'color': Colors.white},
        ];

        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              height: displaysize.height * .3,
              width: displaysize.width * .5,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: dialogdata[value]['color']!,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(dialogdata[value]['gif']!, repeat: false),
                  Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ).then((_) {
      // Mark dialog as completed when manually closed
      if (!dialogCompleter.isCompleted) {
        dialogCompleter.complete();
      }
    });
  }
}

Future<void> logoutreset() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_id');
  await prefs.setBool('status', false);
  await prefs.remove('fcm_notifications');
}

SnackBar CustomSnackBar(String textdata) {
  return SnackBar(
    duration: Duration(seconds: 2),
    content: Text(
      textdata,
      style:
          TextStyle(fontSize: displaysize.height * .015, color: Colors.white),
    ),
    backgroundColor: appColor,
  );
}
