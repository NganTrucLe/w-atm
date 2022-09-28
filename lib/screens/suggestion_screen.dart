import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watm/dummy_bank.dart';
import 'package:watm/screens/bank_list_screen.dart';
import 'package:watm/tab_item.dart';
import 'package:watm/theme/colors.dart';
import 'package:watm/theme/theme_constants.dart';
import 'package:watm/widgets/modal_widget.dart';

import '../models/FilterModel';
import 'map_screen.dart';

class SuggestionScreen extends StatefulWidget {
  static const routeName = '/suggestion';
  final Function(int) selectTabItem;

  SuggestionScreen(this.selectTabItem);

  @override
  _SuggestionScreenState createState() => _SuggestionScreenState(selectTabItem);
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  final Function(int) selectTabItem;
  _SuggestionScreenState(this.selectTabItem);

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
    if (double.parse(amount.text) < 50000 ||
        double.parse(amount.text) > 10000000) {
      this.message = "Your amount is below daily ATM withdrawal limit";
      this.instruction = "Change your amount to view suggestion.";
    } else if (bank.text == "" || amount.text == "") {
      this.message = "You haven’t fill amount yet";
      this.instruction = "Cancel to view map without filling amount.";
    }
    //print(bank.text);
    //print(double.parse(amount.text));

    var filter = context.read<FilterModel>();
    filter.update(message, instruction, bank.text, amount.text);
    selectTabItem(1);
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
                    filled: true,
                    fillColor: AppColors().white,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors().neutral800)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors().neutral800)),
                  ),
                  style: TextStyle(
                    color: AppColors().primary500,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                  ),
                  onSubmitted: (_) => submitData(),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Amount',
                  style: subheadRegular,
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  cursorColor: AppColors().primary500,
                  controller: amount,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'VND',
                        style: TextStyle(
                          fontFamily: "SF Pro Text",
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: AppColors().neutral800,
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors().white,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors().neutral800)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors().neutral800)),
                  ),
                  style: TextStyle(color: AppColors().primary500),
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Filter',
                  style: subheadRegular,
                ),
                SizedBox(
                  height: 8,
                ),
                SwitchListTile(
                  title: Text(
                    'Withdrawing',
                    style: headlineSemibold,
                  ),
                  value: _withdrawing,
                  onChanged: (bool value) {
                    setState(() {
                      _withdrawing = value;
                    });
                  },
                  activeColor: AppColors().primary500,
                ),
                SwitchListTile(
                  title: Text(
                    'Deposit',
                    style: headlineSemibold,
                  ),
                  value: _deposit,
                  onChanged: (bool value) {
                    setState(() {
                      _deposit = value;
                    });
                  },
                  activeColor: AppColors().primary500,
                ),
                SwitchListTile(
                  title: Text(
                    'New notes',
                    style: headlineSemibold,
                  ),
                  value: _newNotes,
                  onChanged: (bool value) {
                    setState(() {
                      _newNotes = value;
                    });
                  },
                  activeColor: AppColors().primary500,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: CupertinoButton(
                color: AppTheme.colors.primary500,
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
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            backgroundColor: Color.fromARGB(255, 249, 249, 249),
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  CupertinoSliverNavigationBar(
                    largeTitle: Text(
                      'View suggestions',
                    ),
                    border: null,
                  )
                ];
              },
              body: appBody,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('View suggestions',
                  style: TextStyle(
                    color: Colors.black,
                  )),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            body: appBody,
          );
  }
}
