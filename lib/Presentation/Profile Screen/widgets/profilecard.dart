import 'package:blood_bank_application/Global/colors.dart';
import 'package:flutter/material.dart';

class Profilecard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String subvalue;
  const Profilecard(
      {super.key,
      required this.icon,
      required this.value,
      required this.subvalue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.black),
              SizedBox(width: 10),
              Text(
                value,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.black),
              )
            ],
          ),
          Text(
            subvalue,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 13, color: appColor),
          )
        ],
      ),
    );
  }
}
