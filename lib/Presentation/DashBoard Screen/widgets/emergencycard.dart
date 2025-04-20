import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';

class Emergencycard extends StatelessWidget {
  final IconData icon;
  final String value;

  const Emergencycard({
    super.key,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: displaysize.height * .005),
      child: Row(
        children: [
          Icon(icon, size: displaysize.height * .025, color: appColor),
          SizedBox(width: displaysize.width * .03),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: displaysize.height * .014,
            ),
          ),
        ],
      ),
    );
  }
}
