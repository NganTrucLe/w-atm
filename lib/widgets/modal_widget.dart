import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ModalWidget extends StatelessWidget {
  final String message;
  final String instruction;
  ModalWidget({required this.message, required this.instruction});
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        title: Text(
          message,
        ),
        content: Text(
          instruction,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Cancel"),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text("Change it"),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
  }
}
