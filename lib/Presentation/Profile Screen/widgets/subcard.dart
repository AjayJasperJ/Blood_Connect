import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';

class ProfileSubcard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const ProfileSubcard(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 2,
          shadowColor: Colors.grey.withValues(alpha: .5),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: displaysize.width * .04,
                vertical: displaysize.height * .015),
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: appColor,
                    child: Icon(icon, color: Colors.white)),
                SizedBox(width: size.width * 0.05),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
    );
  }
}
