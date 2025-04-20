import 'package:blood_bank_application/Global/colors.dart';
import 'package:flutter/material.dart';


class LoginButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const LoginButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.06,
        decoration: BoxDecoration(
            //gradient: LinearGradient(colors: [Colors.black, redcolor]),
            color: appColor,
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
