import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/classes/database_helper.dart';
import 'package:task_manager/classes/task.dart';
import 'package:task_manager/constants/database_functions.dart';
import 'package:task_manager/constants/theme.dart';
import 'package:task_manager/screens/add_task_screen.dart';
import 'package:task_manager/widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Task> tasks;
  int count;

  @override
  Widget build(BuildContext context) {
    if (tasks == null) {
      tasks = List<Task>();
    }
    updateListView();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Icon(Icons.add, size: 32.0, color: Colors.white),
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10.0))),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              context: context,
              builder: (BuildContext context) {
                return AddTaskScreen();
              });
        },
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: darkThemeEnabled
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, top: 32.0),
                      child: Row(
                        children: [
                          Text(
                            'Upcoming Tasks',
                            style: TextStyle(fontSize: 32.0),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        child: getList(),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  getList() {
    if (tasks.length == 0) {
      return Text('No Tasks');
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              TaskTile(
                taskTitle: this.tasks[index].name,
                isChecked: false,
                checkboxCallback: (checkboxState) {
                  setState(() {
                    delete(context, this.tasks[index], databaseHelper);
                    updateListView();
                  });
                },
                longPressCallback: () {
                  showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Row(
                          children: <Widget>[
                            Icon(Icons.warning),
                            Text('Warning') // TODO: Bold Style
                          ],
                        ),
                        content: Text(
                            'Do you want to delete this task?'), // TODO: Info Style
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                delete(context, tasks[index], databaseHelper);
                                updateListView();
                                Navigator.of(context).pop();
                              },
                              child: Text('Yes')), //TODO: Choice Style
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No')) // TODO: Choice Style
                        ],
                      ));
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 5.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              ),
            ],
          );
        },
        itemCount: count,
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Task>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.tasks = todoList;
          this.count = todoList.length;
        });
      });
    });
  }
}
