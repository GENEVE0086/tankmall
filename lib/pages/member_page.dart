import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:tankmall/provide/cart.dart';
import 'package:tankmall/provide/deliver_provide.dart';


class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('会员中心'),
     ),
     body:ListView(
       children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(),
          _actionList()
        
       ],
     ) ,
   );
  }

  //头像区域

  Widget _topHeader(){

    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30), 
            child: ClipOval(
              
              child:Image(
                image: AssetImage("asset/GENEVE_LOGO.png"),
                width: ScreenUtil().setWidth(187.5),
                height: ScreenUtil().setHeight(187.5),
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'GENEVE',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color:Colors.white,

              ),
            ),
          )
        ],
      ),
    );

  }

  //我的订单顶部
  Widget _orderTitle(){

    return Container(
      margin: EdgeInsets.only(top:10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:BorderSide(width: 1,color:Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title:Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );

  }

  Widget _orderType() {
    return Provide<CartProvide>(builder: (context, child, val) {
      bool isBooked = Provide.value<DeliveryProvide>(context).isBooked;
      return Container(
        margin: EdgeInsets.only(top: 5.0),
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(150),
        padding: EdgeInsets.only(top: 20),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                    // Navigator.pop(context);
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(187),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.query_builder,
                          size: 30,
                        ),
                        Text('待付款')
                      ],
                    ),
                  ),
                ),
                Provide<CartProvide>(
                  builder: (context, child, val) {
                    int goodsCount =
                        Provide.value<CartProvide>(context).allGoodsCount;
                    return Positioned(
                        top: 0,
                        right: 10,
                        child: isBooked
                            ? Container(
                          padding:
                          EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border:
                            Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            '$goodsCount',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(22)),
                          ),
                        )
                            : Container());
                  },
                )
              ],
            ),
            Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: ScreenUtil().setWidth(187),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.query_builder,
                          size: 30,
                        ),
                        Text('待发货')
                      ],
                    ),
                  ),
                ),
                Provide<CartProvide>(
                  builder: (context, child, val) {
                    return Container();
                  },
                )
              ],
            ),
            Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.directions_transit,
                    size: 30,
                  ),
                  Text('待收货')
                ],
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.comment,
                    size: 30,
                  ),
                  Text('待评价')
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
  Widget _myListTile(String title){

    return Container(
       decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:BorderSide(width: 1,color:Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
            _myListTile('领取优惠券'),
            _myListTile('已领取优惠券'),
            _myListTile('地址管理'),
            _myListTile('客服电话'),
            _myListTile('关于我们'),
        ],
      ),
    );
  }




}