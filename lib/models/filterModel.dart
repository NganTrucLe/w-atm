import 'package:flutter/material.dart';
import './atm.dart';

class FilterModel extends ChangeNotifier {
  FilterATM filterATM = new FilterATM();


  void update(FilterATM filterATM) {
    this.filterATM = filterATM;
    notifyListeners();
  }

  FilterATM getFilterATM(){
    return this.filterATM;
  }
}