import 'package:flutter/material.dart';
import 'package:protofac/screens/main_screen.dart';
import 'task.dart';

// A widget for creating a new task
class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  // A form key for validating the input fields
  final _formKey = GlobalKey<FormState>();

  // Controllers for the input fields
  final _nameController = TextEditingController();
  final _unitsController = TextEditingController();
  final _startController = TextEditingController();
  final _endController = TextEditingController();

  // A method for creating a new task from the input fields
  Task createTask() {
    return Task(
      _nameController.text,
      int.parse(_unitsController.text),
      DateTime.parse(_startController.text),
      DateTime.parse(_endController.text),
    );
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
          onPressed: () {
            // Add your onPressed code here!
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => Main_screen()));
          },
        ),
        title: Text(
          'New Task',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            height: 25.0 / 18.0,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Task Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(
                        color: Color.fromRGBO(107, 107, 107, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                        hintText: 'Add Task Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a task name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Target Units",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _unitsController,
                      style: TextStyle(
                        color: Color.fromRGBO(107, 107, 107, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                        hintText: 'Add Number of Units to be completed for this task',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a number of units';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Date",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10,),
                        // A TextFormField for the start date input box
                        SizedBox(
                          width: 148,
                          child: TextFormField(
                            controller: _startController, // Use the controller to update the text
                            style: TextStyle(
                              color: Color.fromRGBO(107, 107, 107, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.calendar_month),
                              suffixIconColor: Colors.black,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                              hintText: 'Start Date',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            readOnly: true, // Make the input box read only
                            onTap: () async {
                              // Show the date picker dialog and wait for the result
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              );
                              if (date != null) {
                                // Update the controller text with the selected date
                                _startController.text = date.toString().substring(0, 10);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "End Date",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10,),
                        // A TextFormField for the end date input box
                        SizedBox(
                          width: 148,
                          child: TextFormField(
                            controller: _endController, // Use the controller to update the text
                            style: TextStyle(
                              color: Color.fromRGBO(107, 107, 107, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.calendar_month),
                              suffixIconColor: Colors.black,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                              hintText: 'End Date',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            readOnly: true, // Make the input box read only
                            onTap: () async {
                              // Show the date picker dialog and wait for the result
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              );
                              if (date != null) {
                                // Update the controller text with the selected date
                                _endController.text = date.toString().substring(0, 10);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(28, 105, 255, 1),
                  foregroundColor: Color.fromRGBO(255, 255, 255, 1),
                ),
                onPressed: () {
                  // Validate and submit the form
                  if (_formKey.currentState!.validate()) {
                    // Create a new task and pop it to the previous page
                    Navigator.pop(context, createTask());
                  }
                },
                child: Text('Create Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
