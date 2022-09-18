import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:watm/theme/colors.dart';

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
    print(bank.text);
    print(double.parse(amount.text));
    print(_withdrawing);
    print(_deposit);
    print(_newNotes);
  }

  Future<void> _bankSelection(BuildContext context) async {
    final name = await Navigator.of(context).pushNamed('/banks');
    bank.text = name.toString();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
            body: Container(
                padding: EdgeInsets.all(16),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Account Informations',
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
                                borderSide:
                                    BorderSide(color: AppColors().neutral800)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors().neutral800)),
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
                                borderSide:
                                    BorderSide(color: AppColors().neutral800)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors().neutral800)),
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
                            'New Notes',
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: submitData,
                          child: Text(
                            'Apply',
                            style: headlineSemibold,
                          ),
                          style: ElevatedButton.styleFrom(
                              onPrimary: AppColors().white,
                              primary: AppColors().primary500,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
