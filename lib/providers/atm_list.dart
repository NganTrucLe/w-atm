import 'package:flutter/material.dart';
import '../models/atm.dart';
import '../widgets/status_tag.dart';

class ATMs with ChangeNotifier {
  List<ATM> _items = [];
  bool isFiltered = false;
  FilterATM _filter = FilterATM();

  List<ATM> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<ATM> itemsWithFilter() {
    return _items
        .where((element) =>
            element.bank.contains(_filter.bank) &&
            element.minimumLimit >= _filter.cash &&
            !(!element.newNotes &&
                _filter.newNotes &&
                (element.type == Type.Both || element.type == _filter.type)))
        .toList();
  }

  List<ATM> get listATMs {
    return isFiltered ? itemsWithFilter() : items;
  }

  void updateFilter(FilterATM filterATM) {
    this._filter = filter;
    this.isFiltered = true;
    notifyListeners();
    print("Filter Updated");
  }

  void removeFilter() => this.isFiltered = false;

  FilterATM get filter {
    return this._filter;
  }

  List<ATM> findByNames(String names) {
    //return _items.firstWhere((prod) => prod.id == id);
    return [];
  }

  void addATM(ATM tmp) {
    _items.add(tmp);
    notifyListeners();
  }
}
