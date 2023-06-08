import 'package:flutter/material.dart';
import 'package:protofac/components/Workflow_list.dart';

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
    print('Adding new list');
    setState(() {
      lists.add(Workflow_list(title: 'New Title', date: '08/06/2023', tasksCompleted: 0));
    });
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
