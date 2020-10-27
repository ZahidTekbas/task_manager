import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCustomDialogiOS(BuildContext context, String msg) {
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(msg, style: TextStyle()),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
