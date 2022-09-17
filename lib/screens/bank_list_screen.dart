import 'package:flutter/material.dart';

import 'package:watm/theme/theme_constants.dart';

class BankList extends StatelessWidget {
  List<String> images = [
    "assets/images/ACB.png",
    "assets/images/Bac A Bank.png",
    "assets/images/BIDV.png",
    "assets/images/HDBank.png",
    "assets/images/KienLongBank.jpg",
    "assets/images/sacom new.png",
    "assets/images/MB Bank.png",
    "assets/images/OCB.png",
    "assets/images/PVcombank.jpg",
    "assets/images/SeABank.png",
    "assets/images/Standard Chartered Bank.png",
    "assets/images/TPbank.png",
    "assets/images/VPBank.png",
  ];
  List<String> bankNames = [
    "ACB Bank",
    "Bac A Bank",
    "BIDV Bank",
    "HD Bank",
    "Kien Long Bank",
    "Sacombank",
    "MB Bank",
    "OCB Bank",
    "PV Bank",
    "SeA Bank",
    "Standard Chartered Bank",
    "TP Bank",
    "VP Bank",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(24)),
              child: TextField(
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
          ),
          ListView.builder(
            itemBuilder: (BuildContext, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.colors.white,
                    backgroundImage: AssetImage(images[index]),
                  ),
                  title: Text(
                    bankNames[index],
                    style: TextStyle(
                      fontFamily: 'SF-Pro-Text',
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
            itemCount: images.length,
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
          ),
        ],
      ),
    );
  }
}
