import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:todoapp/drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                        return Container(
                          height: MediaQuery.of(context).size.height * 1,
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
        body: InkWell(
          onTap: () => print("Double tap"),
          child: const Center(
            child: Text('Here will be a list of tasks'),
          ),
        ));
  }
}
