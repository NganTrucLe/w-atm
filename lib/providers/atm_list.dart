import 'package:flutter/material.dart';
import '../models/atm.dart';
import '../widgets/status_tag.dart';

class ATMs with ChangeNotifier {
  List<ATM> _items = [];

  List<ATM> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<ATM> findByNames(String names) {
    //return _items.firstWhere((prod) => prod.id == id);
    return [];
  }

  void addATM(ATM tmp) {
    _items.add(tmp);
  }
}
