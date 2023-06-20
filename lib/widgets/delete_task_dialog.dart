import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteTaskPage extends StatefulWidget {
  final String projectId;
  final String taskId;

  DeleteTaskPage({required this.projectId, required this.taskId});

  @override
  _DeleteTaskPageState createState() => _DeleteTaskPageState();
}

class _DeleteTaskPageState extends State<DeleteTaskPage> {

  void _DeleteTask() async {
    try {
      await FirebaseFirestore.instance
          .collection('projects')
          .doc(widget.projectId)
          .collection('tasks')
          .doc(widget.taskId)
          .delete();
      Navigator.pop(context);
      print('Task deleted successfully');
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Task Tag'),
              ),
              ElevatedButton(
                onPressed: _DeleteTask,
                child: Text('Delete Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
