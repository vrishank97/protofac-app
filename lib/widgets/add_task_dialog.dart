// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskAlertDialog extends StatefulWidget {
  final String projectId;
  const AddTaskAlertDialog({Key? key, required this.projectId})
      : super(key: key);

  @override
  State<AddTaskAlertDialog> createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  final Map<String, Color> taskTags = {
    'To START': Colors.black,
    'PROGRESS': Colors.black,
    'DONE': Colors.black,
  };
  late String selectedValue = '';
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text('New Task', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 50,bottom: 0),
        child: Form(
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      "Task Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Nunito'
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 45,
                    child: TextFormField(
                      controller: taskNameController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        hintText: 'Add Task Name',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.bubble_left_bubble_right,
                      color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading:
                    const Icon(CupertinoIcons.calendar, color: Colors.brown),
                title: Text(
                  selectedStartDate == null
                      ? 'Select a start date'
                      : 'Start Date: ${DateFormat('dd/MM/yyyy').format(selectedStartDate!)}',
                  style: const TextStyle(fontSize: 14),
                ),
                onTap: () => _selectStartDate(context),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading:
                    const Icon(CupertinoIcons.calendar, color: Colors.brown),
                title: Text(
                  selectedEndDate == null
                      ? 'Select an end date'
                      : 'End Date: ${DateFormat('dd/MM/yyyy').format(selectedEndDate!)}',
                  style: const TextStyle(fontSize: 14),
                ),
                onTap: () => _selectEndDate(context),
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  const Icon(CupertinoIcons.tag, color: Colors.brown),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Add a task tag',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: taskTags.entries
                          .map(
                            (entry) => DropdownMenuItem<String>(
                              value: entry.key,
                              child: Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: entry.value,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) => setState(
                        () {
                          if (value != null) selectedValue = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final taskName = taskNameController.text;
                      final taskDesc = taskDescController.text;
                      final taskTag = selectedValue;
                      if (taskName.isNotEmpty &&
                          taskDesc.isNotEmpty &&
                          taskTag.isNotEmpty) {
                        _addTasks(
                          taskName: taskName,
                          taskDesc: taskDesc,
                          taskTag: taskTag,
                        ).then((value) {
                          Navigator.of(context).pop();
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all the fields'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                    ),
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedStartDate)
      setState(() {
        selectedStartDate = picked;
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: selectedStartDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedEndDate)
      setState(() {
        selectedEndDate = picked;
      });
  }

  Future _addTasks(
      {required String taskName,
      required String taskDesc,
      required String taskTag}) async {
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .collection('tasks')
        .add(
      {
        'taskName': taskName,
        'taskDesc': taskDesc,
        'taskTag': taskTag,
        'startDate': selectedStartDate?.toUtc(),
        'endDate': selectedEndDate?.toUtc(),
        'created_at': DateTime.now().toLocal(),
      },
    );
    String taskId = docRef.id;
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .collection('tasks')
        .doc(taskId)
        .update(
      {'id': taskId},
    );
    _clearAll();
  }

  void _clearAll() {
    taskNameController.clear();
    taskDescController.clear();
    setState(() {
      selectedValue = '';
      selectedStartDate = null;
      selectedEndDate = null;
    });
  }
}
