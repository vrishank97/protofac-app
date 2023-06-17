// ignore_for_file: prefer_const_constructors, avoid_types_as_parameter_names

import 'package:flutter/material.dart';

// A model class for a task
class Task {
  final String name;
  final int units;
  final DateTime start;
  final DateTime end;

  Task(this.name, this.units, this.start, this.end);
}

// A widget for displaying a task card
class TaskCard extends StatelessWidget {
  final Task task;
  final DateTime creationTime;
  final int index;

  const TaskCard({Key? key, required this.task,required this.index, required this.creationTime, required int })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color.fromRGBO(227, 227, 227, 1),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Task ${index + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text('Updated: $creationTime',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(129, 129, 129, 1),
                      ),
                    ),
                  ],
                ),
                Text(task.name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black)),
              ],
            ),
            // Text('Start date: ${task.start.toString().substring(0, 10)}'),
            // Text('Start date: ${task.end.toString().substring(0, 10)}'),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 2),
              decoration: BoxDecoration(
                color: Color.fromRGBO(225, 225, 225, 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "TO START",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color.fromRGBO(112, 112, 112, 1),
                ),
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios,size: 10,),
          ],
        ),
      ),
    );
  }
}
