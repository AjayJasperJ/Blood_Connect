import 'package:blood_bank_application/Global/colors.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class MyCustomAlertDialog {
  showCustomAlertdialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    bool button = false,
    required Function() onTapOkButt,
    Function()? onTapCancelButt,
  }) async {
    return Platform.isIOS
        ? showCupertinoDialog(
          barrierDismissible: false,
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: <Widget>[
                if (button == true)
                  CupertinoDialogAction(
                    child: const Text('Cancel'),
                    onPressed: () => onTapCancelButt!(),
                  ),
                CupertinoDialogAction(
                  child: const Text('Ok'),
                  onPressed: () => onTapOkButt(),
                ),
              ],
            ),
          )
        : showDialog(

          barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey[300]
,                  title: Text(title,style: TextStyle(color: Colors.black,fontSize: 16),),
                  content: Text(subtitle,style: TextStyle(color: Colors.black,fontSize: 13),),
                  actions: <Widget>[
                    if (button == true)
                      ElevatedButton(
                        child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                        onPressed: () => onTapCancelButt!(),
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: appColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child:  Text('Ok',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      onPressed: () => onTapOkButt(),
                    ),
                  ]);
            });
  }
}
