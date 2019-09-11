import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:tankmall/pages/loading_page.dart';
import 'package:tankmall/pages/login/login_page.dart';
import 'package:tankmall/provide/cart.dart';
import 'package:tankmall/provide/category_goods_list.dart';
import 'package:tankmall/provide/category_item_list.dart';
import 'package:tankmall/provide/child_category.dart';
import 'package:tankmall/provide/counter.dart';
import 'package:tankmall/provide/currentIndex.dart';
import 'package:tankmall/provide/deliver_provide.dart';
import 'package:tankmall/provide/details_info.dart';
import 'package:tankmall/provide/search_text_provide.dart';
import 'package:tankmall/routers/application.dart';
import 'package:tankmall/routers/routes.dart';

void main() {
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var categoryItemListProvide = CategoryItemListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var deliveryProvide = DeliveryProvide();
  var searchDetailProvider = SearchDetailProvider();
  var counter = Counter();
  var providers = Providers();

  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<CategoryItemListProvide>.value(categoryItemListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<DeliveryProvide>.value(deliveryProvide))
    ..provide(Provider<SearchDetailProvider>.value(searchDetailProvider))
    ..provide(Provider<Counter>.value(counter));

  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
          title: 'TankMall',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Application.router.generator,
          theme: ThemeData(
            primaryColor: Colors.pink,
          ),
          home: LoadingPage(),
          routes: <String, WidgetBuilder>{
            '/LoginPage': (BuildContext context) => LoginPage()
          }),
    );
  }
}
