import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_manager/classes/database_helper.dart';
import 'package:task_manager/classes/task.dart';
import 'package:task_manager/widgets/android/android_alert.dart';
import 'package:task_manager/widgets/ios/ios_alert.dart';

void save(
    Task todo, BuildContext context, DatabaseHelper databaseHelper) async {
  //moveToLastScreen();
  //Navigator.pop

  int result;
  if (todo.id != null) {
    // Case 1: Update operation
    result = await databaseHelper.updateTodo(todo);
  } else {
    // Case 2: Insert Operation
    result = await databaseHelper.insertTodo(todo);
  }

  if (result != 0) {
    if (Platform.isAndroid) {
      showCustomDialogAndroid(context, 'Task successfully created');
    } else {
      showCustomDialogiOS(context, 'Task successfully created');
    }
  } else {
    if (Platform.isAndroid) {
      showCustomDialogAndroid(context, 'Failed');
    } else {
      showCustomDialogiOS(context, 'Failed');
    }
  }
}

  Future<int> delete(BuildContext context,Task todo, DatabaseHelper databaseHelper) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      if (Platform.isAndroid) {
        showCustomDialogAndroid(context, 'Task successfully deleted');
      } else {
        showCustomDialogiOS(context, 'Task successfully deleted');
      }
    } else {
      if (Platform.isAndroid) {
        showCustomDialogAndroid(context, 'Failed while deleting task');
      } else {
        showCustomDialogiOS(context, 'Failed while deleting task');
      }
    }
  }
