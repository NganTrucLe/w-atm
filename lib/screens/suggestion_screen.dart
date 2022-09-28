import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watm/dummy_bank.dart';
import 'package:watm/models/atm.dart';
import 'package:watm/models/bank.dart';
import 'package:watm/screens/bank_list_screen.dart';
import 'package:watm/theme/colors.dart';
import 'package:watm/theme/theme_constants.dart';
import 'package:watm/widgets/modal_widget.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:watm/widgets/status_tag.dart';
import '../models/atm.dart';
import 'package:geocoding/geocoding.dart';

class SuggestionScreen extends StatefulWidget {
  static const routeName = '/suggestion';

  SuggestionScreen();

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
  List<ATM> resultATMs = [];
  List<ATM> list = [];
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

  Future<dynamic> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    return await json.decode(response);
  }

  @override
  void initState() {
    readJson().then((data) async {
      setState(() {
        var listATM =
            data["District 1"] + data["District 2"] + data["District 3"];
        listATM.map((item) async {
          List<Location> locations = await locationFromAddress(item['Address']);
          Status ATMStatus = item["Status"] == Status.maintenance.name
              ? Status.maintenance
              : item["Status"] == Status.crowded.name
                  ? Status.crowded
                  : Status.working;
          Type ATMType = item['Type'] == Type.Withdraw.name
              ? Type.Withdraw
              : item['Type'] == Type.Deposit.name
                  ? Type.Deposit
                  : Type.Both;

          list.add(ATM(
              bank: item["Bank"] ?? "",
              name: item["Name"] ?? "",
              address: item["Address"] ?? "",
              phone: item["Phone"] ?? "",
              type: ATMType,
              cashThroughBank: item["CTB"] == 1 ? true : false,
              status: ATMStatus,
              latitude: locations[0].latitude,
              longitude: locations[0].longitude));
        }).toList();
      });
    });

    bank.text = "";
    resultATMs = [];
    amount.text = "";
    super.initState();
  }

  bool submitData() {
    if (double.parse(amount.text) < 50000 ||
        double.parse(amount.text) > 10000000) {
      this.message = "Your amount is below daily ATM withdrawal limit";
      this.instruction = "Change your amount to view suggestion.";
      return true;
    } else if (bank.text == "" || amount.text == "") {
      this.message = "You haven’t fill amount yet";
      this.instruction = "Cancel to view map without filling amount.";
      return true;
    } else {
      //print(_deposit);
      //print(_withdrawing);
      if (!(_deposit || _withdrawing)) {
        resultATMs = list
            .where((element) =>
                element.bank.toLowerCase().contains(bank.text.toLowerCase()) &&
                element.status != Status.maintenance)
            .toList();
        print(list[0].bank.contains(bank.text));
      } else {
        Type check;
        if (_deposit && _withdrawing)
          check = Type.Both;
        else if (_deposit)
          check = Type.Deposit;
        else
          check = Type.Withdraw;
        List<ATM> filter1 = list
            .where((element) =>
                element.bank.toLowerCase().contains(bank.text.toLowerCase()) &&
                element.type == check &&
                element.status != Status.maintenance)
            .toList();
        resultATMs = filter1;
      }
      if (resultATMs.isEmpty) {
        this.message = "Oh no";
        this.instruction = "No ATMs Found.";
        return true;
      }
      print(resultATMs);
      return false;
      // use data to filter
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
                  if (submitData()) _showAlertDialog(context);
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
