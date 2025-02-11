import 'package:flutter/material.dart';
import 'package:todoapp/models.dart';

class AddToDo extends StatefulWidget {
  void Function({required TaskItemValue taskItem}) taskItem;
  AddToDo({super.key, required this.taskItem});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  TextEditingController _tC1 = TextEditingController();
  TextEditingController _tC2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Text("Add a new To-Do"),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _tC1,
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
                controller: _tC2,
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
                      widget.taskItem(
                          taskItem: TaskItemValue(
                              title: _tC1.text ?? "Task 1",
                              description: _tC2.text ?? "No description",
                              isDone: false)); // Print the task
                      _tC1.clear();
                    },
                    child: Text("Add Task"))),
          ],
        ),
      ],
    );
  }
}
