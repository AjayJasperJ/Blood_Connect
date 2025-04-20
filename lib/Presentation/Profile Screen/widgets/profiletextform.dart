import 'package:blood_bank_application/Global/colors.dart';
import 'package:flutter/material.dart';

class Profiletextform extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final  String? Function(String?)? validator;

  const Profiletextform({super.key, required this.hint, required this.icon, required this.controller,required this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: TextStyle(fontSize: 12),
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.6),
          filled: true,
          prefixIcon: Icon(
            icon,
            color: appColor,
          ),
          hintText: hint,
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
              borderSide: const BorderSide(color: Colors.white)),
        ),
        validator: validator,
      ),
    );
  }
}
