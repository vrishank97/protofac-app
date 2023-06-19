import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/add_task_dialog.dart';
// ignore_for_file: unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/delete_task_dialog.dart';
import '../widgets/update_task_dialog.dart';


class ProjectTasksPage extends StatefulWidget {
  final String projectId;
  final String projectName;

  const ProjectTasksPage({Key? key, required this.projectId, required this.projectName}) : super(key: key);

  @override
  State<ProjectTasksPage> createState() => _ProjectTasksPageState();
}

class _ProjectTasksPageState extends State<ProjectTasksPage> {
  @override
    final fireStore = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectName),
      ),
        body: Container(
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: fireStore.collection('projects').snapshots(),
          builder: (context, projectSnapshot) {
            if (!projectSnapshot.hasData) {
              return const Text('No projects to display');
            } else {
              return ListView.builder(
                itemCount: projectSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot projectDoc = projectSnapshot.data!.docs[index];
                  Map<String, dynamic> projectData =
                      projectDoc.data()! as Map<String, dynamic>;
                  String projectId = projectDoc.id;
    
                  return ExpansionTile(
                    title: Text(projectData['projectName']),
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                AddTaskAlertDialog(projectId: projectId),
                          );
                        },
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: fireStore
                            .collection('projects')
                            .doc(projectId)
                            .collection('tasks')
                            .snapshots(),
                        builder: (context, taskSnapshot) {
                          if (!taskSnapshot.hasData) {
                            return const Text('No tasks to display');
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: taskSnapshot.data!.docs.length,
                              itemBuilder: (context, taskIndex) {
                                DocumentSnapshot taskDoc =
                                    taskSnapshot.data!.docs[taskIndex];
                                Map<String, dynamic> taskData =
                                    taskDoc.data()! as Map<String, dynamic>;
    
                                // Task rendering code
                                Color taskColor = AppColors.blueShadeColor;
                                var taskTag = taskData['taskTag'];
                                if (taskTag == 'Work') {
                                  taskColor = AppColors.salmonColor;
                                } else if (taskTag == 'School') {
                                  taskColor = AppColors.greenShadeColor;
                                }
                                return Container(
                                  height: 100,
                                  margin: const EdgeInsets.only(bottom: 15.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.shadowColor,
                                        blurRadius: 5.0,
                                        offset: Offset(0,
                                            5), // shadow direction: bottom right
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      width: 20,
                                      height: 20,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        backgroundColor: taskColor,
                                      ),
                                    ),
                                    title: Text(taskData['taskName']),
                                    subtitle: Text(taskData['taskDesc']),
                                    isThreeLine: true,
                                    trailing: PopupMenuButton(
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            value: 'edit',
                                            child: const Text(
                                              'Edit',
                                              style: TextStyle(fontSize: 13.0),
                                            ),
                                            onTap: () {
                                              String taskId = taskDoc.id;
                                              String taskName =
                                                  taskData['taskName'];
                                              String taskDesc =
                                                  taskData['taskDesc'];
                                              String taskTag =
                                                  taskData['taskTag'];
                                              Future.delayed(
                                                const Duration(seconds: 0),
                                                () => showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      UpdateTaskAlertDialog(
                                                    taskId: taskId,
                                                    taskName: taskName,
                                                    taskDesc: taskDesc,
                                                    taskTag: taskTag,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          PopupMenuItem(
                                            value: 'delete',
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(fontSize: 13.0),
                                            ),
                                            onTap: () {
                                              String taskId = taskDoc.id;
                                              String taskName =
                                                  taskData['taskName'];
                                              Future.delayed(
                                                const Duration(seconds: 0),
                                                () => showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DeleteTaskDialog(
                                                          taskId: taskId,
                                                          taskName: taskName),
                                                ),
                                              );
                                            },
                                          ),
                                        ];
                                      },
                                    ),
                                    dense: true,
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
            floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskAlertDialog(projectId: widget.projectId),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
