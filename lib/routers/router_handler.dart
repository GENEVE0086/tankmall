import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:tankmall/pages/login/login_page.dart';
import 'package:tankmall/pages/member_page.dart';
import 'package:tankmall/pages/payment_page.dart';
import 'package:tankmall/pages/search_page.dart';

import '../pages/details_page.dart';

Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  print('index>details goodsID is ${goodsId}');
  return DetailsPage(goodsId);
});

Handler searchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SearchPage();
    }
);
//
Handler logOrRegHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      // String tempText = params['text'].first;
      // print('index>detail is $tempText');
      return LoginPage();
    }
);

Handler paymentHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      // String tempText = params['text'].first;
      // print('index>detail is $tempText');
      return PaymentPage();
    }
);

Handler memberHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      // String tempText = params['text'].first;
      // print('index>detail is $tempText');
      return MemberPage();
    }
);