import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/bottom_navbar_provider.dart';
import './providers/origins_provider.dart';
import './providers/atms_provider.dart';
import './providers/atm_provider.dart';
import './theme/theme_constants.dart';
import './app.dart';
import './models/filterModel.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FilterModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ATMs(),
        ),
        ChangeNotifierProvider.value(
          value: OriginsProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'W-ATM',
        theme: AppTheme.lightTheme,
        home: ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (_) => BottomNavigationBarProvider(),
          child: const App(),
        ),
      ),
    );
  }
}
