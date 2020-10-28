import 'package:flutter/material.dart';
import 'package:task_manager/classes/database_helper.dart';
import 'package:task_manager/classes/task.dart';
import 'package:task_manager/constants/database_functions.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:task_manager/constants/theme.dart';

class AddTaskScreen extends StatefulWidget {
  final Function toggleNavBar;
  AddTaskScreen({this.toggleNavBar});
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  String newTaskTitle;
  String newTaskDesc;

  TextEditingController controllerDesc = new TextEditingController();
  TextEditingController controllerTitle = new TextEditingController();

  List<String> options = ['Daily', 'Weekly', 'Monthly'];
  int tag = 0;

  @override
  void dispose() {
    controllerDesc.dispose();
    controllerTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          darkThemeEnabled ? backgroundColorDark : backgroundColorLight,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controllerTitle,
                    onChanged: (newText) {
                      newTaskTitle = newText;
                    },
                    autofocus: true,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Task Title',
                      hintStyle:
                          darkThemeEnabled ? tileStyleDark : tileStyleLight,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controllerDesc,
                    onChanged: (newText) {
                      newTaskDesc = newText;
                    },
                    autofocus: true,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description ',
                      hintStyle:
                          darkThemeEnabled ? tileStyleDark : tileStyleLight,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChipsChoice.single(
                    value: tag,
                    onChanged: (val) => setState(() => tag = val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      backgroundColor:
                          darkThemeEnabled ? fabButtonDark : fabButtonLight,
                      heroTag: "btn2",
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child:
                          Icon(Icons.cancel, size: 32.0, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FloatingActionButton(
                      backgroundColor:
                          darkThemeEnabled ? fabButtonDark : fabButtonLight,
                      heroTag: "btn3",
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Icon(Icons.save, size: 32.0, color: Colors.white),
                      onPressed: () {
                        int date;
                        if (options[tag] == 'Daily') {
                          date = DateTime.now().day;
                        }
                        if (options[tag] == 'Weekly') {
                          date = DateTime.now().day;
                        }
                        if (options[tag] == 'Monthly') {
                          date = DateTime.now().month;
                        }
                        Task task = new Task(
                            name: newTaskTitle,
                            description: newTaskDesc,
                            type: options[tag],
                            date: date);
                        save(task, context, databaseHelper);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
