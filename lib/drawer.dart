import 'package:flutter/material.dart';

class DrawerTemp extends StatelessWidget {
  const DrawerTemp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          side: BorderSide(color: Color.fromARGB(255, 10, 18, 1), width: 1),
        ),
        elevation: 3,
        width: 300,
        child: Text("Drawer"),
      ),
    );
  }
}
