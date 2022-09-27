import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watm/dummy_bank.dart';
import 'package:watm/screens/bank_list_screen.dart';
import 'package:watm/theme/colors.dart';
import 'package:watm/widgets/modal_widget.dart';

class SuggestionScreen extends StatefulWidget {
  static const routeName = '/suggestion';

  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  TextEditingController bank = TextEditingController();
  TextEditingController amount = TextEditingController();

  bool _withdrawing = false;
  bool _deposit = false;
  bool _newNotes = false;
  String message = "demo";
  String instruction = "demo";
  TextStyle subheadRegular = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  TextStyle headlineSemibold = TextStyle(
    fontFamily: "SF Pro Text",
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    bank.text = "";
    amount.text = "";
    super.initState();
  }

  void submitData() {
    if (_withdrawing && _deposit && _newNotes) {
      this.message = "Your amount is below daily ATM withdrawal limit";
      this.instruction = "Change your amount to view suggestion.";
    } 
    else if (bank.text == "" || amount.text == "") {
      this.message = "You haven’t fill amount yet";
      this.instruction = "Cancel to view map without filling amount.";
    }
    //print(bank.text);
    //print(double.parse(amount.text));
  }

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

  Future<void> _bankSelection(BuildContext context) async {
    final name = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BankList(list: DUMMY_BANKS),
      ),
    );
    name != null ? bank.text = name.toString() : bank.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final appBody = Container(
      padding: EdgeInsets.all(16),
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Account informations',
                  style: subheadRegular,
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  onTap: () {
                    _bankSelection(context);
                  },
                  readOnly: true,
                  showCursor: false,
                  controller: bank,
                  decoration: InputDecoration(
                    labelText: 'Bank',
                    labelStyle: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.normal,
                        color: AppColors().neutral500,
                        fontSize: 17),
                    suffixIcon: Icon(
                      Icons.list,
                      color: AppColors().neutral500,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
                        child: CupertinoButton.filled(
                          onPressed: () {
                            submitData();
                            _showAlertDialog(context);
                          },
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              fontFamily: "SF Pro Text",
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
