import 'package:flutter/material.dart';
import 'package:watm/screens/account_screen.dart';
import 'package:watm/screens/suggestion_screen.dart';
import './tab_item.dart';
import './screens/map_screen.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key,
      required this.navigatorKey,
      required this.tabItem,
      required this.selectTabItem});

  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;
  final Function(int) selectTabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context) {
        Widget screen = MapScreen();
        if (tabItem.name == 'Account')
          screen = AccountScreen();
        else if (tabItem.name == 'Suggestion')
          screen = SuggestionScreen(selectTabItem);
        return screen;
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name!]!(context),
        );
      },
    );
  }
}
