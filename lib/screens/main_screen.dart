// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:protofac/components/Workflow_list.dart';
import 'package:intl/intl.dart';
import 'package:protofac/screens/Report_screen.dart';
import 'package:protofac/screens/profile_screen.dart';
import 'package:protofac/screens/workflow_screen.dart';

class Main_screen extends StatefulWidget {
  const Main_screen({super.key});

  @override
  State<Main_screen> createState() => _Main_screenState();
}

class _Main_screenState extends State<Main_screen> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
  Workflow_screen(),
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
      body: _pages[ _selectedIndex],
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
