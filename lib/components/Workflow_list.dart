import 'package:flutter/material.dart';

class Workflow_list extends StatelessWidget {
  final String title;
  final String date;
  final int tasksCompleted;

  Workflow_list({required this.title, required this.date, required this.tasksCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            title,
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
          Container(
            child: Row(children: [
              Text(
                'Date: $date',
                style: TextStyle(fontFamily: 'Nunito', fontSize: 13),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 170),
                  child: Icon(Icons.arrow_forward_ios, size: 15)),
            ]),
          ),
          SizedBox(height: 24),
          Text(
            'Task Completed: $tasksCompleted',
            style: TextStyle(fontFamily: 'Nunito', fontSize: 13),
          ),
        ],
      ),
    );
  }
}




 