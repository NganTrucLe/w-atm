import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:watm/providers/bottom_navbar_provider.dart';
import 'package:watm/theme/theme_constants.dart';

import './tab_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.suggestion),
        _buildItem(TabItem.map),
        _buildItem(TabItem.account),
      ],
      onTap: (index) => provider.selectTab(TabItem.values[index]),
      currentIndex: provider.currentTab.index,
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
}
