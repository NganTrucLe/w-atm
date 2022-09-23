import 'package:flutter/material.dart';
import 'package:watm/dummy_bank.dart';
//import './dummy_bank.dart';
import 'package:watm/theme/theme_constants.dart';

class BankList extends StatelessWidget {
  static const routeName = '/banks';
  
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
              child: Container(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        onTap: () {
                          routeArgs = DUMMY_BANKS[index].name;
                          Navigator.of(context).pop(routeArgs);
                        },
                        leading: CircleAvatar(
                          backgroundColor: AppTheme.colors.white,
                          backgroundImage:
                              AssetImage(DUMMY_BANKS[index].avatarLink),
                        ),
                        title: Text(
                          DUMMY_BANKS[index].name,
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
                  itemCount: DUMMY_BANKS.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
