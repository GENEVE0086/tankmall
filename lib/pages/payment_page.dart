import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:tankmall/provide/cart.dart';
import 'package:tankmall/provide/deliver_provide.dart';
import 'package:tankmall/routers/application.dart';

import 'cart_page/cart_item.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isBooked = Provide.value<DeliveryProvide>(context).isBooked;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('填写订单'),
        ),
        body: FutureBuilder(
            future: _getCartInfo(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List cartList = Provide.value<CartProvide>(context).cartList;
                return Stack(
                  children: <Widget>[
                    Provide<CartProvide>(
                      builder: (context, child, val) {
                        cartList = isBooked
                            ? []
                            : Provide.value<CartProvide>(context).cartList;
                        return ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (context, index) {
                            return CartItem(cartList[index]);
                          },
                        );
                      },
                    ),
                    Positioned(
                      bottom: 60,
                      child: Column(
                        children: <Widget>[
                          accountInfo(),
                          Divider(
                            height: 10,
                            color: Colors.blue,
                          ),
                          payMethod(),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: paymentBottom(),
                    )
                  ],
                );
              } else {
                return Text('正在加载...');
              }
            }));
  }

  Widget accountInfo() {
    return Container(
      decoration: BoxDecoration(color: Colors.blue[50]),
      padding: EdgeInsets.fromLTRB(12, 10, 3, 10),
      height: ScreenUtil.getInstance().setHeight(280),
      width: ScreenUtil.getInstance().setWidth(750),
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil.getInstance().setHeight(60),
            padding: EdgeInsets.only(top: 2),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    '默认',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil.getInstance().setSp(20)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(color: Colors.black12),
                  child: Text(
                    '学校',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil.getInstance().setSp(20)),
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(right: 5),

                  child: Text(
                    '湖南省长沙市天心区城区',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil.getInstance().setSp(30)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: ScreenUtil.getInstance().setHeight(120),
            width: ScreenUtil.getInstance().setWidth(720),
            child: Row(
              children: <Widget>[
                Container(
                  height: ScreenUtil.getInstance().setHeight(90),
                  width: ScreenUtil.getInstance().setWidth(600),
                  child: Text(
                    '天心区韶山南路文源街道中南大学铁道学院铁一舍',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil.getInstance().setSp(36)),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  padding: EdgeInsets.all(0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          Container(
              width: ScreenUtil.getInstance().setWidth(730),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 2, 5, 2),
                height: ScreenUtil.getInstance().setHeight(40),
                child: Text(
                  '毛毛毛  132****7888',
                  style:
                  TextStyle(fontSize: ScreenUtil.getInstance().setSp(24)),
                ),
              ))
        ],
      ),
    );
  }

  Widget payMethod() {
    return Container(
      decoration: BoxDecoration(color: Colors.blue[50]),
      height: ScreenUtil.getInstance().setHeight(120),
      width: ScreenUtil.getInstance().setWidth(750),
      padding: EdgeInsets.fromLTRB(12, 2, 4, 10),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil.getInstance().setWidth(600),
            child: Text(
              '支付方式                                                          在线支付',
              style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(26)),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget paymentBottom() {

    return Provide<CartProvide>(builder: (context, child, val) {
      bool isBooked = Provide.value<DeliveryProvide>(context).isBooked;
      double allPrice = Provide.value<CartProvide>(context).allPrice;
      return Container(
        width: ScreenUtil.getInstance().setWidth(750),
        height: ScreenUtil.getInstance().setHeight(120),
        decoration: BoxDecoration(
          color: Colors.blue[50],
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: ScreenUtil.getInstance().setHeight(100),
              width: ScreenUtil.getInstance().setWidth(250),
              padding: EdgeInsets.fromLTRB(12, 8, 0, 8),
              child: Text(
                !isBooked ?'￥$allPrice':'￥0.00',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: ScreenUtil.getInstance().setSp(54)),
              ),
            ),
            SizedBox(
              width: 120,
            ),
            Container(
              width: ScreenUtil.getInstance().setWidth(250),
              padding: EdgeInsets.only(top: 4, bottom: 4, right: 10),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.blue,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Colors.blue,
                child: Text(
                  '提交订单',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(30),
                      color: Colors.white),
                ),
                onPressed: () {
                  Provide.value<CartProvide>(context).remove();
                  Provide.value<CartProvide>(context).allPrice=0;
                  Provide.value<DeliveryProvide>(context).changebookState();
                  Application.router.navigateTo(context, '/memberPage');
                },
              ),
            )
          ],
        ),
      );
    });
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
