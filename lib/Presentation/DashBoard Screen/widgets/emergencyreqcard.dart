import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/widgets/emergencyalertdetails.dart';
import 'package:blood_bank_application/Presentation/DashBoard%20Screen/widgets/emergencycard.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';

ButtonStyle CustomElevatedButtonTheme() {
  return ButtonStyle(
          splashFactory: InkSplash.splashFactory,
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(displaysize.width * .025))),
          shadowColor: WidgetStatePropertyAll(Colors.grey),
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(Colors.white))
      .copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.red.withValues(alpha: .05);
        }
        return null;
      },
    ),
  );
}

class EmergencyRequestCard extends StatefulWidget {
  final String id;
  final String patientName;
  final String contactno;
  final String bloodrequired;
  final String bloodUnitsRequired;
  const EmergencyRequestCard({
    super.key,
    required this.id,
    required this.patientName,
    required this.contactno,
    required this.bloodrequired,
    required this.bloodUnitsRequired,
  });

  @override
  State<EmergencyRequestCard> createState() => _EmergencyRequestCardState();
}

class _EmergencyRequestCardState extends State<EmergencyRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(displaysize.width * .025),
          boxShadow: [
            BoxShadow(
                blurRadius: displaysize.height * .01,
                offset: Offset(0, 0),
                color: Colors.grey.shade300)
          ]),
      height: displaysize.height * .2,
      width: displaysize.width * .9,
      child: ElevatedButton(
        style: CustomElevatedButtonTheme(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Emergencyalertdetails(id: widget.id)),
          );
        },
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Person Details",
                  style: TextStyle(color: appColor),
                ),
                Emergencycard(
                    icon: Icons.person,
                    value: 'Patient Name : ${widget.patientName}'),
                Emergencycard(
                    icon: Icons.phone_android,
                    value: 'Contact No : ${widget.contactno}'),
                Emergencycard(
                    icon: Icons.bloodtype,
                    value: 'Blood Required : ${widget.bloodrequired}'),
                Emergencycard(
                    icon: Icons.bloodtype,
                    value: 'Units Required : ${widget.bloodUnitsRequired}'),
              ],
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: appColor,
                  size: displaysize.height * .025,
                ),
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
