import 'package:flutter/material.dart';
import 'package:todoapp/models.dart';

class addToDo extends StatefulWidget {
  final void Function({required TaskItemValue taskItem}) taskItem;
  const addToDo({super.key, required this.taskItem});

  @override
  State<addToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<addToDo> {
  late TextEditingController _tC1;
  late TextEditingController _tC2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Text("Add a new Task"),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _tC1 = TextEditingController(),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5.0),
                  hintText: "Enter your task name",
                  labelText: "Task name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _tC2 = TextEditingController(),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5.0),
                  hintText: "Enter your task description",
                  labelText: "Description",
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (_tC1.text.isEmpty || _tC2.text.isEmpty) {
                        return;
                      }
                      widget.taskItem(
                          taskItem: TaskItemValue(
                              title: _tC1.text,
                              description: _tC2.text,
                              isDone: false)); // Print the task
                      _tC1.clear();
                      _tC2.clear();
                    },
                    child: Text("Add Task"))),
          ],
        ),
      ],
    );
  }
}
