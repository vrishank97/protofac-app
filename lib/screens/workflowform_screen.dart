import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:protofac/models/workflow_model.dart';
import 'package:protofac/screens/workflowformwidget.dart';

class WorkflowFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WorkflowFormScreenState();
  }
}

class _WorkflowFormScreenState extends State<WorkflowFormScreen> {
  List<WorkflowFormWidget> workflowForms = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Workflow",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          color: Colors.deepOrange,
          onPressed: () {
            onSave();
          },
          child: Text("Save", style: TextStyle(color: Colors.white)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: () {
          onAdd();
        },
      ),
      body: Column(
        children: [
          workflowForms.isNotEmpty
              ? ListView.builder(
                  itemCount: workflowForms.length,
                  itemBuilder: (_, index) {
                    return workflowForms[index];
                  })
              : Center(child: Text("Tap on + to Add Step")),
        ],
      ),
    );
  }

  onSave() {
    bool allValid = true;

    workflowForms.forEach((element) => allValid = (allValid));

    if (allValid) {
      List<String?> names =
          workflowForms.map((e) => e.workflowStep.name).toList();
      debugPrint("$names");
    } else {
      debugPrint("Form is Not Valid");
    }
  }

  //Delete specific form
  onRemove(WorkflowStep contact) {
    setState(() {
      int index = workflowForms
          .indexWhere((element) => element.workflowStep.id == contact.id);

      if (workflowForms != null) workflowForms.removeAt(index);
    });
  }

  onAdd() {
    setState(() {
      WorkflowStep _workflowModel = WorkflowStep(id: workflowForms.length);
      workflowForms.add(WorkflowFormWidget(
        index: workflowForms.length,
        workflowStep: _workflowModel,
        onRemove: () => onRemove(_workflowModel),
      ));
    });
  }
}
