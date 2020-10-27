import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        bottom: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.blue[100],
          tabs: [
            Tab(child: Text('Daily')),
            Tab(child: Text('Weekly')),
            Tab(child: Text('Monthly'))
          ],
        ),
      ),
      body: TabBarView(controller: _tabController,children: [
        // Daily Tasks
        // Weekly Tasks
        // Monthly Tasks
        Text('Monthly'),
        Text('Monthly'),
        Text('Monthly'),
      ],)
    );
  }
}
