import 'package:flutter/cupertino.dart';
import 'package:tankmall/model/category_item_list_entity.dart';

class CategoryItemListProvide with ChangeNotifier {
  List<Item> itemList = [];

  //点击大类时更换商品列表
  getItemList(List<Item> list) {
    itemList = list;
    notifyListeners();
  }

  //上拉加载列表
  addGoodsList(List<Item> list) {
    itemList.addAll(list);
    notifyListeners();
  }
}