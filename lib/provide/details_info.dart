import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tankmall/model/item_detail_entity.dart';

import '../service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {
  ItemDetailEntity itemDetail;
  bool isLeft = true;
  bool isRight = false;

  //从后台获取商品信息

  getGoodsInfo(String id) async {
//    await request('getGoodDetailById',formData:formData).then((val){
//      var responseData= json.decode(val.toString());
//      itemDetail=ItemDetailEntity.fromJson(responseData);
//      notifyListeners();
//    });
    await getRequest('http://47.101.180.71:8080/catalog/item/$id').then((val) {
      var res = json.decode(val.toString());
      itemDetail = ItemDetailEntity.fromJson(res);
      notifyListeners();
    });
  }

  //改变tabBar的状态
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
