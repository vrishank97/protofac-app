// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_protofac/screens/profile_screen.dart';
import '../screens/report_screen.dart';
import '../widgets/add_task_dialog.dart';
import 'home.dart';

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
  late int _selectedIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    Report_screen(),
    Profile_screen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/workflow.png', height: 17, width: 17),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/report.png', height: 15, width: 15),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Task_list extends StatefulWidget {
  const Task_list({super.key});

  @override
  State<Task_list> createState() => _Task_listState();
}

class _Task_listState extends State<Task_list> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
