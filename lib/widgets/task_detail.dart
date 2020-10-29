import 'package:flutter/material.dart';
import 'package:task_manager/classes/task.dart';
import 'package:task_manager/constants/theme.dart';

class TaskDetail extends StatefulWidget {
  final Task task;
  TaskDetail({this.task});
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  Task task;
  @override
  void initState() {
    task = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkThemeEnabled ? backgroundColorDark : backgroundColorLight,
      body: SafeArea(
        right: true,
        left: true,
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Card(
            color: darkThemeEnabled ? cardColorDark : cardColorLight,
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel,
                                size: 32.0,
                                color: darkThemeEnabled
                                    ? iconColorLight
                                    : iconColorDark))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Title',
                          style: darkThemeEnabled
                              ? headerThreeStyleDark
                              : headerThreeStyleLight),
                      subtitle: Text(task.name,
                          style: darkThemeEnabled
                              ? headerTwoStyleDark
                              : headerTwoStyleLight),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      isThreeLine: true,
                      title: Text('Description',
                          style: darkThemeEnabled
                              ? headerThreeStyleDark
                              : headerThreeStyleLight),
                      subtitle: Text(task.description,
                          style: darkThemeEnabled
                              ? headerTwoStyleDark
                              : headerTwoStyleLight),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Type',
                          style: darkThemeEnabled
                              ? headerThreeStyleDark
                              : headerThreeStyleLight),
                      subtitle: Text(task.type,
                          style: darkThemeEnabled
                              ? headerTwoStyleDark
                              : headerTwoStyleLight),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
