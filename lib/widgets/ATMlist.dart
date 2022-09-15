import 'package:flutter/material.dart';
import 'package:watm/screens/atmDetails_screen.dart';
import '../models/atm.dart';

class ATMlist extends StatelessWidget {
  static const List<ATM> ATMitem = [
    ATM(bank: 'ACB', name: 'Tan Son Nhi'),
    ATM(bank: 'ACB', name: 'Au Co')
  ];
  @override
  void selectATM(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      ATMDetailsScreen.routeName,
    )
        .then((result) {
      if (result != null) {
        // removeItem(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 16),
          height: 200,
          child: ListView.builder(
            itemCount: ATMitem.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                    margin: EdgeInsets.only(right: 16),
                    width: 320,
                    height: 120,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(child: Text(ATMitem[0].bank)));
              
            },
          ),
          //   ListView(
          // scrollDirection: Axis.horizontal,
          // //controller: scrollController,

          // children: [
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Container(
          //         width: 200,
          //         decoration: BoxDecoration(
          //           color: Colors.grey,
          //           borderRadius: BorderRadius.circular(15),
          //         ),
          //         child: InkWell(child: Text(ATMitem[0].bank))),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Container(
          //         width: 200,
          //         decoration: BoxDecoration(
          //           color: Colors.grey,
          //           borderRadius: BorderRadius.circular(15),
          //         ),
          //         child: InkWell(child: Text(ATMitem[1].bank))),
        ),
      ],
      //),
      //),
      // ],
    );
  }
}
