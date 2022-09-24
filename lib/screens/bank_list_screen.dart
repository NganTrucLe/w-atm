import 'package:flutter/material.dart';
import 'package:watm/dummy_bank.dart';
import '../models/bank.dart';
//import './dummy_bank.dart';
import 'package:watm/theme/theme_constants.dart';
import '../widgets/bank_cart.dart';

class BankList extends StatefulWidget {
  static const routeName = '/banks';

  final List<Bank> list;

  BankList({required this.list});

  @override
  _BankList createState() => _BankList();
}

class _BankList extends State<BankList> {
  TextEditingController? _textEditingController = TextEditingController();
  List<BankCard> allBanks = [];
  List<BankCard> bankOnSearch = [];

  @override
  void initState() {
    allBanks = widget.list.map((bank) => BankCard(bank)).toList();
    bankOnSearch = widget.list.map((bank) => BankCard(bank)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var routeArgs = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: Text('ATM Details',
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    bankOnSearch = allBanks
                        .where((element) => element.BankInfo.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                controller: _textEditingController,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                  prefixIcon: Icon(
                    Icons.search_sharp,
                    color: AppTheme.colors.neutral600,
                  ),
                  hintText: "Search",
                ),
              ),
            ),
            Expanded(
              child: _textEditingController!.text.isNotEmpty &&
                      bankOnSearch.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, size: 60),
                          SizedBox(height: 15),
                          Text(
                            'No Results Found',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _textEditingController!.text.isNotEmpty
                          ? bankOnSearch.length
                          : allBanks.length,
                      itemBuilder: (content, index) {
                        return _textEditingController!.text.isNotEmpty
                            ? bankOnSearch[index]
                            : allBanks[index];
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
