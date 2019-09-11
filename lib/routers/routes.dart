import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import './router_handler.dart';

class Routes {
  static String root = '/';
  static String detailsPage = '/detail';
  static String searchPage = '/search';
  static String searchResultPage = '/searchResult';
  static String logOrRegPage = '/logOrReg';
  static String paymentPage = '/paymentPage';
  static String memberPage = '/memberPage';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ERROR====>ROUTE WAS NOT FONUND!!!');
    });
    router.define(detailsPage, handler: detailsHandler);
    router.define(searchPage, handler: searchHandler);
//    router.define(logOrRegPage, handler: logOrRegHandler);
    router.define(paymentPage, handler: paymentHandler);
    router.define(memberPage, handler: memberHandler);
  }
}
