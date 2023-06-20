// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateTaskPage extends StatefulWidget {
  final String projectId;
  final String taskId;

  UpdateTaskPage({required this.projectId, required this.taskId});

  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskTagController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  double _value = 0;
  int?
      _totalUnits; // Create a nullable variable to store the total number of units

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateSliderValue);
    _fetchTotalUnits(); // Fetch the total units from Firestore when the widget is initialized
  }

  @override
  void dispose() {
    _controller.removeListener(_updateSliderValue);
    _controller.dispose();
    super.dispose();
  }

  void _updateSliderValue() {
    double newValue = double.tryParse(_controller.text) ?? 0;
    if (newValue <= _totalUnits!) {
      setState(() {
        _value = newValue;
      });
    } else {
      _controller.text = _value.toString();
    }
  }

  Stream<DocumentSnapshot> _fetchTotalUnits() {
    return FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .collection('tasks')
        .doc(widget.taskId)
        .snapshots();
  }

  void _updateTask() async {
    try {
      await FirebaseFirestore.instance
          .collection('projects')
          .doc(widget.projectId)
          .collection('tasks')
          .doc(widget.taskId)
          .update({
        'taskName': taskNameController.text,
        'taskTag': taskTagController.text,
      });
      Navigator.pop(context);
      print('Task updated successfully');
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 105.0,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 10,
          ),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Task',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            height: 25.0 / 18.0,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Name',
                        // widget.task.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        'Started at blah blah blah',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(129, 129, 129, 1),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(225, 225, 225, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "TO START",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Color.fromRGBO(112, 112, 112, 1),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Expected Start',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'hello',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Expected End',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'hello',
                        // widget.task.end.toString().substring(0, 10),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                ],
              ),
              const Divider(
                color: Color.fromRGBO(236, 236, 236, 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Actual Start',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'hello',
                        // widget.task.actualStartDate
                        // .toString()
                        // .substring(0, 10),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Actual End',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'hello',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Completed Units',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 148,
                            height: 40,
                            child: TextFormField(
                              // ...
                              validator: (value) {
                                double? enteredValue =
                                    double.tryParse(value ?? '');
                                if (_totalUnits != null &&
                                    (enteredValue == null ||
                                        enteredValue > _totalUnits!)) {
                                  return 'Value must be less than or equal to $_totalUnits';
                                }
                                return null;
                              },
                            ),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: _fetchTotalUnits(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (snapshot.connectionState ==
                                      ConnectionState.active &&
                                  snapshot.hasData) {
                                var targetUnits =
                                    snapshot.data!.get('targetUnits');
                                if (targetUnits is int) {
                                  _totalUnits = targetUnits;
                                } else if (targetUnits is String) {
                                  _totalUnits = int.tryParse(targetUnits);
                                } else {
                                  _totalUnits = null;
                                }
                                return Text(_totalUnits != null
                                    ? '$_totalUnits'
                                    : 'Nothing');
                              }

                              return Text('Loading...');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Progress of Task',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.green,
                            inactiveTrackColor:
                                const Color.fromRGBO(183, 183, 183, 1),
                            trackHeight: 24.0,
                            thumbColor: Colors.black,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 12.0,
                              pressedElevation: 8.0,
                            ),
                            overlayColor: Colors.purple.withAlpha(32),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 14.0),
                            valueIndicatorShape:
                                const PaddleSliderValueIndicatorShape(),
                            valueIndicatorColor: Colors.black,
                            valueIndicatorTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          child: Slider(
                              min: 0,
                              value: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              }),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(28, 105, 255, 1),
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                ),
                onPressed: () => _updateTask(),
                child: const Text('Update Task'),
              ),
              const SizedBox(
                height: 49,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
