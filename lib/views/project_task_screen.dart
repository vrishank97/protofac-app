import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_protofac/widgets/add_task_dialog.dart';

class TaskCard extends StatelessWidget {
  final String taskId;
  final String taskName;
  // Add more properties as needed

  const TaskCard({
    Key? key,
    required this.taskId,
    required this.taskName,
    // Add more properties as needed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue, // Use the same background color as the ProjectCard
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Use the same border-radius as the ProjectCard
      ),
      margin: const EdgeInsets.all(8), // Use the same margin as the ProjectCard
      child: Padding(
        padding: const EdgeInsets.all(16), // Use the same padding as the ProjectCard
        child: ListTile(
          title: Text(
            taskName,
            style: TextStyle(
              fontSize: 24, // Use the same font size as the ProjectCard
              fontWeight: FontWeight.bold, // Use the same font weight as the ProjectCard
            ),
          ),
          // Add more UI components as needed
        ),
      ),
    );
  }
}

class ProjectTasksPage extends StatefulWidget {
  final String projectId;

  ProjectTasksPage({Key? key, required this.projectId, required String projectName}) : super(key: key);

  @override
  _ProjectTasksPageState createState() => _ProjectTasksPageState();
}

class _ProjectTasksPageState extends State<ProjectTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Tasks'),
      ),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('projects')
              .doc(widget.projectId)
              .collection('tasks')
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                final taskData =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                return TaskCard(
                  taskId: snapshot.data!.docs[index].id,
                  taskName: taskData['taskName'],
                  // Add more properties as needed
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) =>
                AddTaskAlertDialog(projectId: widget.projectId),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Task'),
        backgroundColor: Color.fromRGBO(28, 105, 255, 1),
      ),
    );
  }
}

