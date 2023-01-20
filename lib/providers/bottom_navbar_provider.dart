import 'package:flutter/cupertino.dart';
import 'package:watm/tab_item.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  TabItem _currentTab = TabItem.map;
  TabItem get currentTab => _currentTab;
  set currentTab(TabItem tab) {
    _currentTab = tab;
    notifyListeners();
  }

  final _navigatorKeys = {
    TabItem.suggestion: GlobalKey<NavigatorState>(),
    TabItem.map: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };
  get navigatorKeys => _navigatorKeys;
  void selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      currentTab = tabItem;
    }
  }
}
