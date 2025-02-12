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
  final List<TaskItemValue> _tasks = [];
  void changeMenuString({required TaskItemValue taskItem}) async {
    // Make the function async
    bool taskExists = _tasks.any((element) => element.title == taskItem.title);

    if (taskExists) {
      await showDialog(
        // Wait for dialog response
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Already a task with the same name exists!"),
          content: const Text("Already exist!"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        ),
      );
    } else {
      setState(() {
        _tasks.add(taskItem);
      });
    }
    Navigator.pop(context);
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
                leading: IconButton(
                  icon: Icon(FeatherIcons.checkCircle),
                  color: _tasks[index].isDone ? Colors.green : Colors.grey,
                  onPressed: () {
                    setState(() {
                      if (_tasks[index].isDone != true) {
                        _tasks[index].isDone = true;
                      }
                    });
                  },
                ),
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
