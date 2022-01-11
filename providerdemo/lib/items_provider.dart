import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ItemsProvider extends ChangeNotifier {
  List _itemsData = [];
  //creating emty list

  List get getItemData => _itemsData;
  //getter for the list

  //creating function for incrementing the count.
  void incrementCount(int index) {
    _itemsData[index]['count']++;
    notifyListeners();
    //using this we are changing in main.dart file at the run time
  }

  void addItems(String value) {
    //inserting valiue using this function

    _itemsData.add({'title': value, 'count': 0});

    //wheneevr you insert  value you have to use nnotifier listner
    //notifier is for is anything change in app notifylistener requiered
    notifyListeners();
  }
}
