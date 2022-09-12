import 'package:flutter/material.dart';
import 'package:watm/theme/theme_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:watm/theme/colors.dart';
import './screens/tabs_screen.dart';
import './screens/account_screen.dart';
import './screens/map_screen.dart';
import './screens/suggestion_screen.dart';

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
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      // home: Scaffold(),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(),
        SuggestionScreen.routeName: (context) => SuggestionScreen(),
        MapScreen.routeName: (context) => MapScreen(),
        AccountScreen.routeName: (context) => AccountScreen(),
      },
    );
  }
}
