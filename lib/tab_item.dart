import 'package:flutter/material.dart';

enum TabItem {
  suggestion('Suggestion', 'assets/images/suggestion.svg', '/suggestion'),
  map('Map', 'assets/images/map.svg', '/'),
  account('Account', 'assets/images/account.svg', '/account');

  const TabItem(this.name, this.icon, this.routeName);
  final String name;
  final String icon;
  final String routeName;
}