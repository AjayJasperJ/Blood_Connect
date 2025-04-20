import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/widgets/emergencycard.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';

class Organizationwidget extends StatefulWidget {
  final String id;
  final String name;
  final String regno;
  final String contact_no;
  final String email;
  final String city;

  const Organizationwidget(
      {super.key,
      required this.id,
      required this.name,
      required this.regno,
      required this.contact_no,
      required this.email,
      required this.city});

  @override
  State<Organizationwidget> createState() => _OrganizationwidgetState();
}

class _OrganizationwidgetState extends State<Organizationwidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shadowColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displaysize.width * .02)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Organization details',
                  style: TextStyle(
                    fontSize: 16,
                    color: appColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(thickness: 2),
            Emergencycard(
                icon: Icons.location_city_outlined,
                value: 'Organization Name  :  ${widget.name}'),
            Emergencycard(
                icon: Icons.person_pin_outlined,
                value: 'Reg No : ${widget.regno}'),
            Emergencycard(
                icon: Icons.phone_android_outlined,
                value: 'Mobile No : ${widget.contact_no}'),
            Emergencycard(
                icon: Icons.email_outlined, value: 'Email : ${widget.email}'),
            Emergencycard(
                icon: Icons.my_location_outlined,
                value: 'Location : ${widget.city}'),
          ],
        ),
      ),
    );
  }
}
