import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watm/dummy_bank.dart';
import 'package:watm/screens/bank_list_screen.dart';
import 'package:watm/widgets/validation.dart';
import 'package:watm/theme/colors.dart';

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the amount';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
