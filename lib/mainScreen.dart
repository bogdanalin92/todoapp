// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void saveTaskToStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'tasksTitle', _tasks.map((e) => e.title).toList());
    await prefs.setStringList(
        'tasksDescription', _tasks.map((e) => e.description ?? '').toList());

    // Save isDone status safely
    final bool isDone =
        _tasks.isNotEmpty ? _tasks.map((e) => e.isDone).first : false;
    await prefs.setBool('tasksIsDone', isDone);
  }

  void getTaskFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> tasksTitle = prefs.getStringList('tasksTitle') ?? [];
    final List<String> tasksDescription =
        prefs.getStringList('tasksDescription') ?? [];
    final List<bool> tasksIsDone = prefs.getBool('tasksIsDone') != null
        ? [prefs.getBool('tasksIsDone')!]
        : [false];
    for (int i = 0; i < tasksTitle.length; i++) {
      _tasks.add(TaskItemValue(
          title: tasksTitle[i],
          description: tasksDescription[i],
          isDone: tasksIsDone[i]));
    }

    setState(() {});
  }

  void removeTaskFromList() async {
    setState(() {
      _tasks.clear();
    });
    saveTaskToStorage();
  }

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
        saveTaskToStorage();
      });
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    getTaskFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            FeatherIcons.filePlus,
            color: Colors.white,
            opticalSize: 2,
          ),
          onPressed: () {
            showAddModal();
          },
        ),
        drawer: const DrawerTemp(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Todo App'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: const Icon(FeatherIcons.trash2),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  margin: const EdgeInsets.all(10.0),
                ),
                background: Container(
                  color: Colors.green,
                  child: const Icon(FeatherIcons.checkCircle),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
                  margin: const EdgeInsets.all(10.0),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    setState(() {
                      _tasks.removeAt(index);
                      saveTaskToStorage();
                    });
                  } else {
                    setState(() {
                      _tasks[index].isDone = true;
                      saveTaskToStorage();
                    });
                  }
                },
                child: ListTile(
                  title: Text(_tasks[index].title),
                  subtitle: _tasks[index].description != null
                      ? Text(_tasks[index].description!)
                      : null,
                  contentPadding: const EdgeInsets.all(20.0),
                  enableFeedback: true,
                  horizontalTitleGap: 10,
                  leading: IconButton(
                    icon: Icon(FeatherIcons.checkCircle),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          _tasks[index].isDone ? Colors.green : Colors.grey),
                    ),
                    color: _tasks[index].isDone ? Colors.black : Colors.white10,
                    onPressed: () {},
                  ),
                  trailing: Icon(
                    FeatherIcons.trash2,
                  ),
                ),
              );
            }));
  }

  void showAddModal() {
    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        elevation: 2,
        enableDrag: true,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.25,
                    maxHeight: MediaQuery.of(context).size.height * 0.75),
                child: addToDo(
                  taskItem: changeMenuString,
                ),
              ),
            ),
          );
        });
  }
}
