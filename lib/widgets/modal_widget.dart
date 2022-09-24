import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ModalWidget extends StatelessWidget {
  final String message;
  final String instruction;

  ModalWidget(this.message, this.instruction);

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoButton(
        onPressed: () => _showAlertDialog(context),
        child: const Text('Apply'),
      ),
    );
  }
}
