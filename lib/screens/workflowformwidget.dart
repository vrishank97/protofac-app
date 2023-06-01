import 'package:flutter/material.dart';
import 'package:protofac/models/workflow_model.dart';

class WorkflowFormWidget extends StatefulWidget {
  WorkflowFormWidget(
      {Key? key,
      required this.workflowStep,
      required this.onRemove,
      required this.index})
      : super(key: key);

  final int index;
  WorkflowStep workflowStep;
  final Function onRemove;
  final state = _ContactFormItemWidgetState();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class _ContactFormItemWidgetState extends State<WorkflowFormWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Workflow Step - ${widget.index}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.orange),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                //Clear All forms Data
                                widget.workflowStep.name = "";
                                widget.workflowStep.status = "";
                                widget._nameController.clear();
                                widget._statusController.clear();
                              });
                            },
                            child: const Text(
                              "Clear",
                              style: TextStyle(color: Colors.blue),
                            )),
                        TextButton(
                            onPressed: () => widget.onRemove(),
                            child: const Text(
                              "Remove",
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    ),
                  ],
                ),
                TextFormField(
                  controller: widget._nameController,
                  // initialValue: widget.contactModel.name,
                  onChanged: (value) => widget.workflowStep.name = value,
                  onSaved: (value) => widget.workflowStep.name = value!,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter Step Name",
                    labelText: "Workflow Step",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: widget._statusController,
                  onChanged: (value) => widget.workflowStep.status = value,
                  onSaved: (value) => widget.workflowStep.status = value!,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter Status",
                    labelText: "Status",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
