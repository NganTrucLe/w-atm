import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  var _currentTab = TabItem.map;
  final _navigatorKeys = {
    TabItem.suggestion: GlobalKey<NavigatorState>(),
    TabItem.map: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  void _selectTabIndex(int index) {
    TabItem item = _navigatorKeys.entries.toList()[index].key;
    _selectTab(item);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.map) {
            // select 'main' tab
            _selectTab(TabItem.map);
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
            bottomNavigationBar: BottomNavigation(
              currentTab: _currentTab,
              onSelectTab: _selectTab,
            ),
          );
        },
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
          navigatorKey: _navigatorKeys[tabItem],
          tabItem: tabItem,
          selectTabItem: _selectTabIndex),
    );
  }
}
