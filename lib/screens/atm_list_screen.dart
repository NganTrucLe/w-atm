import 'package:flutter/material.dart';
import 'package:watm/models/atm.dart';
import 'package:watm/widgets/atm_result.dart';
import '../theme/theme_constants.dart';
import '../widgets/search_result.dart';

class ListScreen extends StatefulWidget {
  static const routeName = '/list-screen';

  final List<ATM> list;

  ListScreen({required this.list});

  @override
  _ListScreen createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  TextEditingController? _textEditingController = TextEditingController();
  //List<String> atmListOnSearch = [];
  //List<String> atmListOnSearchAddress = [];
  List<ATMResult> allAtm = [];
  List<ATMResult> atmOnSearch = [];

  @override
  void initState() {
    allAtm = widget.list
        .map((atm) => ATMResult(atm, '${atm.bank} - ${atm.name}'))
        .toList();
    atmOnSearch = widget.list
        .map((atm) => ATMResult(atm, '${atm.bank} - ${atm.name}'))
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
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
              hintText: "find an ATM",
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      // body\\\
      // appBar: AppBar(
      //   title: Container(
      //     //margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      //     decoration: BoxDecoration(
      //       color: Colors.blue.shade200,
      //       borderRadius: BorderRadius.circular(15),
      //     ),
      //     child: TextField(
      //       onChanged: (value) {
      //         setState(() {
      //           atmListOnSearch = atmList
      //               .where((element) => element.contains(value))
      //               .toList();
      //         });
      //       },
      //       controller: _textEditingController,
      //       decoration: InputDecoration(
      //         prefixIcon: const Icon(Icons.search),
      //         hintText: 'find an ATM',
      //         contentPadding: EdgeInsets.all(15),
      //         border: InputBorder.none,
      //         errorBorder: InputBorder.none,
      //         enabledBorder: InputBorder.none,
      //         focusedBorder: InputBorder.none,
      //       ),
      //     ),
      //   ),
      // ),
      body: _textEditingController!.text.isNotEmpty && atmOnSearch.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 60),
                  SizedBox(height: 15),
                  Text(
                    'No Results Found',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  )
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
    );
  }
}

// https://www.youtube.com/watch?v=ZHdg2kfKmjI&ab_channel=JohannesMilke
// https://www.youtube.com/watch?v=XIyyZpZiHWc&ab_channel=CodingwithHadi