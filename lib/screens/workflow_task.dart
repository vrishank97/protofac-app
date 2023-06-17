// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, no_logic_in_create_state

import 'package:flutter/material.dart';
import '../components/task.dart';
import './new_task_page.dart';

// A widget for displaying the workflow page
class Workflow_Task extends StatefulWidget {
  const Workflow_Task({Key? key}) : super(key: key);

  @override
  _Workflow_TaskState createState() => _Workflow_TaskState();
}

class _Workflow_TaskState extends State<Workflow_Task> {
  // A list of tasks to display
  List<Task> tasks = [];

  // A list of creation times for each task
  List<DateTime> creationTimes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 105.0,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 10,
          ),
          color: Colors.black,
          onPressed: () {
            // Add your onPressed code here!
          },
        ),
        title: Text(
          'Workflow',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            height: 25.0 / 18.0,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          // Build a task card for each task
          return TaskCard(
            task: tasks[index],
            index: index,
            creationTime: creationTimes[index], int: null,
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Navigate to the new task page and wait for the result
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTaskPage()),
          );

          // If the result is a task, add it to the list and update the state
          if (result is Task) {
            setState(() {
              tasks.add(result);
              creationTimes.add(DateTime.now());
            });
          }
        },
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Text('+  Task',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              height: 1.375,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(28, 105, 255, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
