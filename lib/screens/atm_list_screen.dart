import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:watm/models/atm.dart';
import 'package:watm/widgets/atm_result.dart';
import '../theme/theme_constants.dart';

class ListScreen extends StatefulWidget {
  static const routeName = '/list-screen';

  final List<ATM> list;
  final LatLng origins;

  ListScreen({required this.list, required this.origins});

  @override
  _ListScreen createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  TextEditingController? _textEditingController = TextEditingController();
  List<ATMResult> allAtm = [];
  List<ATMResult> atmOnSearch = [];


  @override
  void initState() {
    allAtm = widget.list
        .map((atm) => ATMResult(ATMInfo: atm, name: '${atm.bank} - ${atm.name}', origins: widget.origins))
        .toList();
    atmOnSearch = widget.list
        .map((atm) => ATMResult(ATMInfo: atm, name: '${atm.bank} - ${atm.name}', origins: widget.origins))
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ATM List',
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
                    atmOnSearch = allAtm
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                controller: _textEditingController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_sharp,
                    color: AppTheme.colors.neutral600,
                  ),
                  hintText: "Find an ATM",
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child:
                  _textEditingController!.text.isNotEmpty && atmOnSearch.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error,
                                size: 60,
                                color: AppTheme.colors.neutral500,
                              ),
                              SizedBox(height: 15),
                              Text(
                                'No Results Found',
                                style: TextStyle(
                                  color: AppTheme.colors.neutral500,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _textEditingController!.text.isNotEmpty
                              ? atmOnSearch.length
                              : allAtm.length,
                          itemBuilder: (content, index) {
                            return _textEditingController!.text.isNotEmpty
                                ? atmOnSearch[index]
                                : allAtm[index];
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
