import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateTaskPage extends StatefulWidget {
  final String projectId;
  final String taskId;

  UpdateTaskPage({required this.projectId, required this.taskId});

  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskTagController = TextEditingController();

  void _updateTask() async {
    try {
      await FirebaseFirestore.instance
          .collection('projects')
          .doc(widget.projectId)
          .collection('tasks')
          .doc(widget.taskId)
          .update({
        'taskName': taskNameController.text,
        'taskTag': taskTagController.text,
      });
      Navigator.pop(context);
      print('Task updated successfully');
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Task')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextField(
                controller: taskNameController,
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
              TextField(
                controller: taskTagController,
                decoration: InputDecoration(labelText: 'Task Tag'),
              ),
              ElevatedButton(
                onPressed: _updateTask,
                child: Text('Update Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
