import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCustomDialogiOS(BuildContext context, String msg) {
  return CupertinoPopupSurface(
      child: Dialog(
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
  ));
}
