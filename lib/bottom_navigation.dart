import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watm/theme/theme_constants.dart';

import './tab_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.currentTab, required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.suggestion),
        _buildItem(TabItem.map),
        _buildItem(TabItem.account),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
      currentIndex: currentTab.index,
      selectedItemColor: AppTheme.colors.primary500,
      unselectedItemColor: AppTheme.colors.neutral500,
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      activeIcon: new SvgPicture.asset(
        tabItem.icon,
        color: AppTheme.colors.primary500,
      ),
      icon: new SvgPicture.asset(
        tabItem.icon,
        color: AppTheme.colors.neutral500,
      ),
      label: tabItem.name,
    );
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item
        ? AppTheme.colors.primary500
        : AppTheme.colors.neutral500;
  }
}
