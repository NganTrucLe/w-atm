import 'package:flutter/material.dart';
import 'package:watm/theme/theme_constants.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';
  static const listOptions = [
    'Connect bank',
    'History',
    'Language',
    'Clear cache',
    'Terms & Privacy Policy',
    'Contact us',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account',
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: 
            listOptions.map((option) => Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: AppTheme.colors.neutral800),
                )
              ),
              child: ListTile(
                title: Text(option),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 24,
                  color: AppTheme.colors.neutral800,
                ),
              ),
            )
            ).toList(),
        ),
      ),
    );
  }
}
