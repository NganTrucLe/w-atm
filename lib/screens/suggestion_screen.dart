import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watm/theme/colors.dart';
import 'package:watm/theme/theme_constants.dart';
import 'package:flutter/src/material/icons.dart';
// import 'package:watm/screens/banklist.dart';

// class SearchBar extends StatefulWidget {
//   @override
//   _SearchBarState createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: AppTheme.colors.neutral800,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20.0),
//                   child: TextField(
//                     decoration: InputDecoration(hintText: 'Search'),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               child: Container(
//                 width: size.width,
//                 height: size.height * 0.1,
//                 alignment: Alignment.center,
//                 child: TextField(
//                   // controller: textController, We will declare this later
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(
//                       Icons.arrow_back_ios_new_sharp,
//                       color: Colors.black,
//                     ),
//                     hintText: "Search",
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25)),
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                         borderSide: BorderSide(width: 2)),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class SuggestionScreen extends StatefulWidget {
  @override
  static const routeName = '/suggestion';
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
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
