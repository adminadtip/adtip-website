import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String name;
  final GlobalKey globalKey;

  const DrawerItem({super.key, required this.name, required this.globalKey});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () {
        Navigator.of(context).pop(); // Close the drawer
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final context = globalKey.currentContext;
          if (context != null) {
            Scrollable.ensureVisible(context,
                duration: const Duration(milliseconds: 300));
          }
        });
      },
    );
  }
}
