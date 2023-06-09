// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:protofac/components/Workflow_list.dart';
import 'package:intl/intl.dart';

class Workflow_screen extends StatefulWidget {
  const Workflow_screen({super.key});

  @override
  State<Workflow_screen> createState() => _Workflow_screenState();
}

class _Workflow_screenState extends State<Workflow_screen> {
  int _selectedIndex = 0;
  List<Workflow_list> lists = [
    Workflow_list(title: 'Title', date: '08/06/2023', tasksCompleted: 3),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addNewList() {
    TextEditingController _titleController = TextEditingController();
    ValueNotifier<bool> _isButtonEnabled = ValueNotifier<bool>(false);

    _titleController.addListener(
      () {_isButtonEnabled.value = _titleController.text.isNotEmpty; },
    );

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "New Workflow",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Name of the Workflow",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Nunito'),
                ),
              )),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 290,
                height: 40,
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Add a name for the workflow',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ValueListenableBuilder<bool>(
              valueListenable: _isButtonEnabled,
              builder: (BuildContext context, bool isEnabled, Widget? child) {
                return Container(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor:
                          isEnabled ? Color.fromRGBO(28, 105, 255, 1) : Colors.grey,
                    ),
                    onPressed: isEnabled
                        ? () {
                            if (_titleController.text.isNotEmpty) {
                              setState(() {
                                DateTime currentDate = DateTime.now().toLocal();
                                String formattedDate =DateFormat('HH:mm:ss dd/MM/yyyy').format(currentDate);
                                lists.add(Workflow_list(
                                    title: _titleController.text,
                                    date: formattedDate,
                                    tasksCompleted: 0));
                              });
                              Navigator.pop(context);
                            }
                          }
                        : null,
                    child: Text('Create a Workflow'),
                  ),
                );
              },
            ),
            ],
          ),
        );
      },
    );
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: Text(
                "Protofac",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Clash Display'),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              right: 200,
            ),
            child: const Center(
              child: Text(
                "Workflows",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito'),
              ),
            ),
          ),
          Column(
            children: lists,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewList,
        icon: Icon(Icons.add),
        label: Text('Workflow'),
        backgroundColor: Color.fromRGBO(28, 105, 255, 1),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/workflow.png', height: 17, width: 17),
            label: 'Workflows',
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
