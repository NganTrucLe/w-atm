import 'package:flutter/material.dart';

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
              icon: Icon(Icons.lightbulb_rounded),
              label: 'Suggestion',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.map_rounded),
              label: 'Map',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                backgroundColor: Colors.white,
                label: 'Account')
          ],
          backgroundColor: Colors.white,
          currentIndex: _selectedPageIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey),
          
    );
  }
}
