import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:watm/widgets/atm_result.dart';
import '../providers/atms_provider.dart';
import '../providers/atm_provider.dart';
import '../theme/theme_constants.dart';

class ListScreen extends StatefulWidget {
  static const routeName = '/list-screen';
  @override
  _ListScreen createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  TextEditingController? _textEditingController = TextEditingController();
  List<ATMProvider> atmOnSearch = [];

  @override
  Widget build(BuildContext context) {
    final allAtm = Provider.of<ATMs>(context, listen: false);
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
                    atmOnSearch = allAtm.items
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
                              : allAtm.items.length,
                          itemBuilder: (content, index) {
                            return _textEditingController!.text.isNotEmpty
                                ? ATMResult(ATMInfo: atmOnSearch[index], name: '${atmOnSearch[index].bank} - ${atmOnSearch[index].name}')
                                : ATMResult(ATMInfo: allAtm.items[index], name: '${allAtm.items[index].bank} - ${allAtm.items[index].name}');
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
