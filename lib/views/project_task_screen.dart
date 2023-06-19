// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_protofac/widgets/add_task_dialog.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final String taskId;
  final String taskName;
  final String taskTag;
  final String created_at;

  TaskCard({
    required this.taskId,
    required this.taskName,
    required this.taskTag,
    required this.created_at,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(227, 227, 227, 1)),
        color: Color(0xFFF6F8FD),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Color(0xFF1C69FF),
            size: 24,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskName,
                  style: TextStyle(
                    color: Color(0xFF1C69FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF1C69FF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      taskTag,
                      style: TextStyle(
                        color: Color(0xFF1C69FF),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'Created At: ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        created_at,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

// TaskCard class remains unchanged

class ProjectTasksPage extends StatefulWidget {
  final String projectId;
  final String projectName;

  ProjectTasksPage(
      {Key? key, required this.projectId, required this.projectName})
      : super(key: key);

  @override
  _ProjectTasksPageState createState() => _ProjectTasksPageState();
}

class _ProjectTasksPageState extends State<ProjectTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FD),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              // color: Colors.white,
              child: Row(
                children: [
                  Padding(padding: const EdgeInsets.only(left: 16.0)),
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Workflows',                 
                    selectionColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),
            ),
           
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Color(0xFFF6F8FD),
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('projects')
                      .doc(widget.projectId)
                      .collection('tasks')
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return const Text("No tasks found for this project.");
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final taskData = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;

                        return TaskCard(
                          taskId: snapshot.data!.docs[index].id,
                          taskName: taskData['taskName'],
                          taskTag: taskData['taskTag'],
                          created_at: DateFormat('dd/MM/yyyy')
                              .format(taskData['created_at']?.toDate() ?? DateTime.now()),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: Color(0xFF1C69FF),
          borderRadius: BorderRadius.circular(28),
        ),
        child: IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) =>
                  AddTaskAlertDialog(projectId: widget.projectId),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
