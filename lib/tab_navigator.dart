import 'package:flutter/material.dart';
import 'package:watm/screens/account_screen.dart';
import 'package:watm/screens/atm_list_screen.dart';
import 'package:watm/screens/bank_list_screen.dart';
import 'package:watm/screens/suggestion_screen.dart';
import './tab_item.dart';
import './screens/map_screen.dart';
import './screens/atm_details_screen.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String suggestion = '/suggestion';
  static const String account = '/account';
  static const String atm_details_screen= '/atm-details-screen';
  static const String atm_list = '/atm-list';
  static const String bank_list = '/bank-list';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key, required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context) => MapScreen(),
      TabNavigatorRoutes.suggestion: (context) => SuggestionScreen(),
      TabNavigatorRoutes.account: (context) => AccountScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: tabItem.routeName,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name!]!(context),
        );
      },
    );
  }
}