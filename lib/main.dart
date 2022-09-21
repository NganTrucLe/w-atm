import 'package:flutter/material.dart';
import 'package:watm/theme/theme_constants.dart';
import './app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'W-ATM',
      theme: AppTheme.lightTheme,
      home: const App(),
    );
  }
}
