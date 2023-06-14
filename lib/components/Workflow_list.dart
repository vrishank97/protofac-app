// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unused_field, camel_case_types, unused_element

import 'package:flutter/material.dart';
import 'package:protofac/screens/task_screen.dart';

class Workflow_list extends StatefulWidget {
  final String title;
  final String date;
  final int tasksCompleted;

  Workflow_list({
    required this.title,
    required this.date,
    required this.tasksCompleted,
  });
  // ignore: avoid_void_async

  @override
  State<Workflow_list> createState() => _Workflow_listState();
}

class _Workflow_listState extends State<Workflow_list> {
  
  bool change_screen = false;

  void changeScreen() async {
    change_screen = true;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Task_screen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              child: Row(children: [
                Text(
                  'Created at: ${widget.date}',
                  style: TextStyle(fontFamily: 'Nunito', fontSize: 13),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, left: 50),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Task_screen()),
                      );
                    },
                  ),
                )
              ]),
            ),
            SizedBox(height: 24),
            Text(
              'Task Completed: ${widget.tasksCompleted}',
              style: TextStyle(fontFamily: 'Nunito', fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
