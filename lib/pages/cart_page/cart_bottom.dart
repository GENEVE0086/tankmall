import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:tankmall/provide/cart.dart';
import 'package:tankmall/provide/deliver_provide.dart';
import 'package:tankmall/routers/application.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        child: Provide<CartProvide>(
          builder: (context, child, val) {
            return Row(
              children: <Widget>[
                selectAllBtn(context),
                allPriceArea(context),
                goButton(context),
              ],
            );
          },
        ));
  }

//全选
  Widget selectAllBtn(context) {
    bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.blue,
            onChanged: (bool val) {
              Provide.value<CartProvide>(context).changeAllCheckBtnState(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

//合计
  Widget allPriceArea(context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    bool isBooked = Provide.value<DeliveryProvide>(context).isBooked;
    return Container(
      width: ScreenUtil().setWidth(400),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(280),
                alignment: Alignment.centerRight,
                child: Text('合计',
                    style: TextStyle(fontSize: ScreenUtil().setSp(36))),
              ),
              Container(
                width: ScreenUtil().setWidth(120),
                alignment: Alignment.centerLeft,
                child: Text(
                  !isBooked ? '￥$allPrice' : '￥0.00',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36), color: Colors.red),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(400),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
            ),
          )
        ],
      ),
    );
  }

// 结算
  Widget goButton(context) {
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
    bool isBooked = Provide.value<DeliveryProvide>(context).isBooked;
    return Container(
      width: ScreenUtil().setWidth(200),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {
          Application.router.navigateTo(context, '/paymentPage');
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3.0)),
          child: Text(
            !isBooked ? '结算($allGoodsCount)':'结算(0)',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
