import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProjectAlertDialog extends StatefulWidget {
  const AddProjectAlertDialog({Key? key}) : super(key: key);

  @override
  State<AddProjectAlertDialog> createState() => _AddProjectAlertDialogState();
}

class _AddProjectAlertDialogState extends State<AddProjectAlertDialog> {
  final TextEditingController projectNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'New Project',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: TextFormField(
        controller: projectNameController,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          hintText: 'Project Name',
          hintStyle: const TextStyle(fontSize: 14),
          icon: const Icon(CupertinoIcons.folder, color: Colors.brown),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final projectName = projectNameController.text;
            _addProject(projectName: projectName);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future _addProject({required String projectName}) async {
    DocumentReference docRef = await FirebaseFirestore.instance.collection('projects').add(
      {
        'projectName': projectName,
      },
    );
    String projectId = docRef.id;
    await FirebaseFirestore.instance.collection('projects').doc(projectId).update(
      {'id': projectId},
    );
    projectNameController.text = '';
  }
}
