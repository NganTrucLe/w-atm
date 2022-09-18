import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watm/theme/theme_constants.dart';
import './account_screen.dart';
import './map_screen.dart';
import './suggestion_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': SuggestionScreen(),
        'title': 'Suggestion',
      },
      {
        'page': MapScreen(),
        'title': 'Map',
      },
      {
        'page': AccountScreen(),
        'title': 'Account',
      }
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            activeIcon: new SvgPicture.asset(
              'assets/images/suggestion.svg',
              color: AppTheme.colors.primary500,
            ),
            icon: new SvgPicture.asset(
              'assets/images/suggestion.svg',
              color: AppTheme.colors.neutral500,
            ),
            label: 'Suggestion',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            activeIcon: new SvgPicture.asset(
              'assets/images/map.svg',
              color: AppTheme.colors.primary500,
            ),
            icon: new SvgPicture.asset(
              'assets/images/map.svg',
              color: AppTheme.colors.neutral500,
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
              activeIcon: new SvgPicture.asset(
                'assets/images/account.svg',
                color: AppTheme.colors.primary500,
              ),
              icon: new SvgPicture.asset(
                'assets/images/account.svg',
                color: AppTheme.colors.neutral500,
              ),
              backgroundColor: Colors.white,
              label: 'Account')
        ],
        backgroundColor: Colors.white,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: AppTheme.colors.neutral500,
      ),
    );
  }
}
