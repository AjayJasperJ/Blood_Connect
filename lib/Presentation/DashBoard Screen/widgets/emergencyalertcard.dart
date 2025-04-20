import 'package:flutter/material.dart';

class Emergencyalertcard extends StatelessWidget {
  final IconData icon;
  final String value;
  const Emergencyalertcard({super.key, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon,size: 20,color: Colors.grey),
          SizedBox(width: 10),
          Text(value,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13))
        ],
      ),
    );
  }
}