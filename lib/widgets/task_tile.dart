import 'package:flutter/material.dart';
import 'package:task_manager/constants/theme.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;
  final Function longPressCallback;

  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.checkboxCallback,
      this.longPressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      title: Text(
        taskTitle,
        style: darkThemeEnabled ? tileStyleDark : tileStyleLight , 
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
      leading: Icon(Icons.touch_app, color: darkThemeEnabled ? iconColorLight : iconColorDark) // TODO: Dynamic Icon
    );
  }
}