import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import 'package:tankmall/model/categoryGoodsList.dart';
import 'package:tankmall/model/category_item_list_entity.dart';
import 'package:tankmall/provide/category_goods_list.dart';
import 'package:tankmall/provide/child_category.dart';
import 'package:tankmall/provide/search_text_provide.dart';
import 'package:tankmall/routers/application.dart';
import 'package:tankmall/service/service_method.dart';

class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = new TextEditingController();
  final FocusNode focusNode1 = new FocusNode();
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    TextField searchField = new TextField(
      cursorColor: Colors.white,
      autofocus: true,
      decoration: new InputDecoration(
          border: InputBorder.none, hintText: '搜索', fillColor: Colors.white),
      focusNode: focusNode1,
      controller: _searchController,
    );
    return Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          title: searchField,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
//                Provide.value<SearchTextProvide>(context)
//                    .getSearchText(_searchController.text);
//                isSearching = Provide.value<SearchTextProvide>(context)
//                    .changeSearchState(isSearching);
                _search(_searchController.text);
              },
            ),
          ],
        ),
        body: Provide<SearchDetailProvider>(
            builder: (context, child, data){
              return Container(
                child: ListView.builder(
                  controller: ScrollController(),
                  itemCount: data.itemList.length,
                  itemBuilder: (context, index) {
                    return _ListWidget(data.itemList, index);
                  },
                ),
              );
            })
    );
  }

  void _search(keyword) {
    getRequest('http://47.101.180.71:8080//catalog/searchItemList/$keyword/items')
        .then((val){
          var data = json.decode(val);
          CategoryItemListModel itemList = CategoryItemListModel.fromJson(data);
          Provide.value<SearchDetailProvider>(context)
              .getItemList(itemList.data.itemList);
    });
  }

  Widget _ListWidget(List newList, int index) {
    return InkWell(
        onTap: () {
          Application.router
              .navigateTo(context, "/detail?id=${newList[index].itemId}");
        },
        child: Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black12))),
          child: Row(
            children: <Widget>[
              _goodsImage(newList, index),
              Column(
                children: <Widget>[
                  _goodsName(newList, index),
                  _goodsPrice(newList, index)
                ],
              )
            ],
          ),
        ));
  }
//商品图片
  Widget _goodsImage(List newList, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].logo),
    );
  }

  //商品名称方法
  Widget _goodsName(List newList, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].itemName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //商品价格方法
  Widget _goodsPrice(List newList, int index) {
    return Container(
        margin: EdgeInsets.only(top: 20.0),
        width: ScreenUtil().setWidth(370),
        child: Row(children: <Widget>[
          Text(
            '价格:￥${newList[index].price}',
            style:
            TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '￥${newList[index].price + 20}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ]));
  }
}
