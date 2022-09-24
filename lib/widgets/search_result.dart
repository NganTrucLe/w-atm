import 'package:flutter/material.dart';
//import './result_status.dart';

class SearchResult extends StatelessWidget {
  static const routeName = '/search-result';
  final String atmName, atmAddress, distance;
  final bool isCrowded;
  SearchResult(this.atmName, this.atmAddress, this.distance, this.isCrowded);
  @override
  Widget build(BuildContext context) {
    return Container(
      // row
      // button (icon, km)  name (name, address)
        child: Text('Suggestions'),
      );
  }
}