import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:todoapp/addToDo.dart';
import 'package:todoapp/drawer.dart';
import 'package:todoapp/models.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _menuString = "Menu";

  List<TaskItemValue> _tasks = [
    new TaskItemValue(title: "Task 1", isDone: false),
  ];
  void changeMenuString({required TaskItemValue taskItem}) {
    setState(() {
      _tasks
          .add(taskItem ?? new TaskItemValue(title: "No title", isDone: false));
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerTemp(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Todo App'),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  // Add task
                  showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      elevation: 3,
                      enableDrag: true,
                      showDragHandle: true,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom *
                                  0.9),
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            height:
                                300, //MediaQuery.of(context).size.height * 1,
                            child: AddToDo(
                              taskItem: changeMenuString,
                            ),
                          ),
                        );
                      });
                },
                child: Icon(
                  FeatherIcons.plusCircle,
                  color: Colors.white70,
                  size: 28,
                  weight: 3,
                ),
              ),
            )
          ],
        ),
        body: ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_tasks[index].title),
                subtitle: _tasks[index].description != null
                    ? Text(_tasks[index].description!)
                    : null,
                contentPadding: const EdgeInsets.all(20.0),
                enableFeedback: true,
                horizontalTitleGap: 10,
                leading: const Icon(FeatherIcons.checkCircle),
                trailing: IconButton(
                  icon: const Icon(FeatherIcons.trash2),
                  onPressed: () {
                    setState(() {
                      _tasks.removeAt(index);
                    });
                  },
                ),
              );
            }));
  }
}
