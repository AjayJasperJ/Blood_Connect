import 'package:blood_bank_application/Global/colors.dart';
import 'package:flutter/material.dart';

class loginTextField extends StatelessWidget {
  final String hintText;
   final IconData icon;
   final TextEditingController controller;
  final  String? Function(String?)? validator;
   final Color color;



  const loginTextField({super.key, required this.hintText, required this.icon, required this.controller,required this.validator,required this.color});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 13),
      controller: controller,
      decoration: InputDecoration(

        fillColor: color,
        filled: true,
        prefixIcon: Icon(icon, color: appColor),

        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColor),
          borderRadius: BorderRadius.circular(10),
        ),
        hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      validator: validator,
    );
  }
}
