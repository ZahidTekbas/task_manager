
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
  List<Task> weeklyTasks;
  List<Task> monthlyTasks;
  int dailyTaskCount;
  int weeklyTaskCount;
  int monthlyTaskCount;

  Color bulbColor = Colors.black;

  @override
  void initState() {
    updateListView();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    if (oldWidget != widget) {
      updateListView();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    updateListView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (tasks == null) {
      tasks = List<Task>();
    }
    if (weeklyTasks == null) {
      weeklyTasks = List<Task>();
    }
    if (monthlyTasks == null) {
      monthlyTasks = List<Task>();
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 8.0,
        heroTag: "btn1",
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
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
              }).then((value) => {
                updateListView(),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upcoming Tasks',
                            style: TextStyle(fontSize: 32.0),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 32.0, top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Daily',
                            style: TextStyle(fontSize: 24.0),
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
                          child: getDailyList()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 32.0, top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Weekly',
                            style: TextStyle(fontSize: 24.0),
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
                          child: getWeeklyList()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 32.0, top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Monthly',
                            style: TextStyle(fontSize: 24.0),
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
                          child: getMonthlyList()),
                    ),
                    SizedBox(height: 50.0),
                    Text('Built with Flutter ❤️',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey.withOpacity(0.5))),
                    SizedBox(height: 50.0),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  getDailyList() {
    if (tasks.length == 0) {
      return Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        Icon(Icons.warning),
        Text('No tasks found in daily list', style: TextStyle(fontSize: 14.0)),
      ],);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: dailyTaskCount,
          itemBuilder: (BuildContext context, index) {
            if (tasks[index].type == 'Daily') {
              return Column(
                children: <Widget>[
                  TaskTile(
                    taskTitle: this.tasks[index].name,
                    isChecked: false,
                    checkboxCallback: (checkboxState) {
                      setState(() {
                        delete(context, this.tasks[index], databaseHelper)
                            .then((value) => {
                                  setState(() {
                                    tasks.remove(this.tasks[index]);
                                    updateListView();
                                  }),
                                });
                      });
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
            }
          }),
    );
  }

  getWeeklyList() {
    if (weeklyTasks.length == 0) {
      return Text('No Tasks');
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: weeklyTaskCount,
          itemBuilder: (BuildContext context, index) {
            if (weeklyTasks[index].type == 'Weekly') {
              return Column(
                children: <Widget>[
                  TaskTile(
                    taskTitle: this.weeklyTasks[index].name,
                    isChecked: false,
                    checkboxCallback: (checkboxState) {
                      setState(() {
                        delete(context, this.weeklyTasks[index], databaseHelper)
                            .then((value) => {
                                  setState(() {
                                    weeklyTasks.remove(this.weeklyTasks[index]);

                                    updateListView();
                                  }),
                                });
                      });
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
            }
          }),
    );
  }

  getMonthlyList() {
    if (monthlyTasks.length == 0) {
      return Text('No Tasks');
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: monthlyTaskCount,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            if (monthlyTasks[index].type == 'Monthly') {
              return Column(
                children: <Widget>[
                  TaskTile(
                    taskTitle: this.monthlyTasks[index].name,
                    isChecked: false,
                    checkboxCallback: (checkboxState) {
                      setState(() {
                        delete(context, this.monthlyTasks[index],
                                databaseHelper)
                            .then((value) => {
                                  setState(() {
                                    monthlyTasks
                                        .remove(this.monthlyTasks[index]);

                                    updateListView();
                                  }),
                                });
                      });
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
            }
          }),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Task>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          todoList.forEach((element) {
            if (element.type == 'Daily') {
              if (tasks.any((e) => e.id == element.id) == false) {
                this.tasks.add(element);
              }
            } else if (element.type == 'Weekly') {
              if (weeklyTasks.any((e) => e.id == element.id) == false) {
                this.weeklyTasks.add(element);
              }
            } else if (element.type == 'Monthly') {
              if (monthlyTasks.any((e) => e.id == element.id) == false) {
                this.monthlyTasks.add(element);
              }
            }
          });
          this.dailyTaskCount = tasks.length;
          this.weeklyTaskCount = weeklyTasks.length;
          this.monthlyTaskCount = monthlyTasks.length;
        });
      });
    });
  }
}
