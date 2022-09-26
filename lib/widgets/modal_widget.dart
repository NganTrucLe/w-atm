// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../theme/colors.dart';

// class ModalWidget extends StatelessWidget {

//   void changeState() {
//     if (check) {
//       this.message = "Your amount is below daily ATM withdrawal limit";
//       this.instruction = "Change your amount to view suggestion.";
//     } else {
//       this.message = "You haven’t fill amount yet";
//       this.instruction = "Cancel to view map without filling amount.";
//     }
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: CupertinoButton.filled(
//         onPressed: () {
//           changeState();
//           _showAlertDialog(context);
//         },
//         child: Text(
//           'Apply',
//           style: TextStyle(
//             fontFamily: "SF Pro Text",
//             fontSize: 17,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }
