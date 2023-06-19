// ignore_for_file: prefer_final_fields, sort_child_properties_last, avoid_unnecessary_containers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/add_task_dialog.dart';

class ProjectTasksPage extends StatefulWidget {
  final String projectId;
  final String projectName;

  const ProjectTasksPage(
      {Key? key, required this.projectId, required this.projectName})
      : super(key: key);

  @override
  State<ProjectTasksPage> createState() => _ProjectTasksPageState();
}

class _ProjectTasksPageState extends State<ProjectTasksPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectName),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('projects')
              .doc(widget.projectId)
              .collection('tasks')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            print(snapshot.data!.docs);

            if (snapshot.data!.docs.isEmpty) {
              return const Text("No tasks found for this project.");
            }

            print(snapshot.data!.docs.length);
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final taskData =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                return ListTile(
                  title: Text(taskData['taskName']),
                  // Add more properties of the task as needed
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                AddTaskAlertDialog(projectId: widget.projectId),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

