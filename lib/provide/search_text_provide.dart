import 'package:flutter/material.dart';
import 'package:tankmall/model/category_item_list_entity.dart';

class SearchTextProvide with ChangeNotifier {
  String searchText = '';
  bool isSearching = false;

  getSearchText(String tempText) {
    searchText = tempText;
    notifyListeners();
  }

  changeSearchState(bool val) {
    if (val) {
      isSearching = false;
    } else {
      isSearching = true;
    }
  }
}

class SearchDetailProvider with ChangeNotifier {
  List<Item> itemList = [];

  getItemList(List<Item> list) {
    itemList = list;
    notifyListeners();
  }
}
