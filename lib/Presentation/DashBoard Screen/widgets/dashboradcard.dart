import 'package:blood_bank_application/Global/colors.dart';
import 'package:blood_bank_application/main.dart';
import 'package:flutter/material.dart';

class Dashboradcard extends StatelessWidget {
  final String title;
  final String image;
  final Function() onTap;

  Dashboradcard({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            GestureDetector(
              onTap: () {
                onTap();
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: displaysize.width * .02,
                    vertical: displaysize.height * .01),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey.shade300,
                          offset: Offset(0, 2))
                    ],
                    borderRadius:
                        BorderRadius.circular(displaysize.width * .02)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: displaysize.height * .06,
                        width: displaysize.height * .06,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: appColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            image,
                            color: Colors.white,
                            width: 35,
                            height: 35,
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 8, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
