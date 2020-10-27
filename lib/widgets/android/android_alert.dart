import 'package:flutter/material.dart';

showCustomDialogAndroid(BuildContext context, String msg) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 100.0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(msg, style: TextStyle()), // TODO: Info Style
                ],
              ),
            ),
          ),
        );
      });
}
