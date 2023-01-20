import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watm/providers/bottom_navbar_provider.dart';
import './bottom_navigation.dart';
import './tab_item.dart';
import './tab_navigator.dart';
import './models/filterModel.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await provider
            .navigatorKeys[provider.currentTab]!.currentState!
            .maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (provider.currentTab != TabItem.map) {
            // select 'main' tab
            provider.selectTab(TabItem.map);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Consumer<FilterModel>(
        builder: (context, filter, child) {
          return Scaffold(
            body: Stack(children: <Widget>[
              _buildOffstageNavigator(TabItem.suggestion),
              _buildOffstageNavigator(TabItem.map),
              _buildOffstageNavigator(TabItem.account),
            ]),
            bottomNavigationBar: BottomNavigation(),
          );
        },
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Offstage(
      offstage: provider.currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: provider.navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
