import 'package:blood_bank_application/Global/colors.dart';
import 'package:flutter/material.dart';

class registerTextField extends StatelessWidget {
final String hintText;
final IconData icon;
final TextEditingController controller;
final  Function()? onTap;
//final  String? Function(String?)? validator;

  const registerTextField({super.key, required this.hintText, required this.icon, required this.controller,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.black, fontSize: 13),
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(0.6),
        filled: true,
        prefixIcon: IconButton(
            icon: Icon(
              icon,
              color: appColor,
            ),
            onPressed: onTap),
        hintText: hintText,


       enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appColor), borderRadius: BorderRadius.circular(10),),
        hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

          borderSide: const BorderSide(color: Colors.white)
        ),
      ),
     //  validator: validator,
    );
  }
}
class registerFieldName extends StatelessWidget {
  final String title;
  const registerFieldName({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      );
  }
}
