import 'package:flutter/material.dart';
import 'package:surf_controllers/surf_controllers.dart';

enum ExampleDialogType {
  text,
}

class ExampleDialogData extends DialogData {
  final String title;
  final String subtitle;

  ExampleDialogData({
    required this.title,
    required this.subtitle,
  });
}

class ExampleDialog extends StatelessWidget {
  final ExampleDialogData data;

  const ExampleDialog({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.title,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Text(
            data.subtitle,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
