// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Workflow_screen extends StatefulWidget {
  const Workflow_screen({super.key});

  @override
  State<Workflow_screen> createState() => _Workflow_screenState();
}

class _Workflow_screenState extends State<Workflow_screen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () {
                // Add your button action here
              },
              icon: Icon(Icons.add, size: 16),
              label: Text('Workflow'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(28, 105, 255, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Border radius
                ),
              ),
            )),
        ListView(children: [
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
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Row(children: [
                    Text(
                      'Date: 08/06/2023',
                      style: TextStyle(fontFamily: 'Nunito', fontSize: 13),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10, left: 170),
                        child: Icon(Icons.arrow_forward_ios, size: 15)),
                  ]),
                ),
                SizedBox(height: 24),
                Text(
                  'Task Completed: 3',
                  style: TextStyle(fontFamily: 'Nunito', fontSize: 13),
                ),
              ],
            ),
          ),
        ]),
      ]),
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
