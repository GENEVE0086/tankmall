import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsWeb extends StatelessWidget {


//  return ListView.builder(
//  itemCount: detail.length,
//  itemBuilder: (context, index){
//  return Image.network(detail[index]);
//  },
//  );
  @override
  Widget build(BuildContext context) {
    var goodsDetail=Provide.value<DetailsInfoProvide>(context).itemDetail;
    List details = goodsDetail.data.itemDetail;
    String detail = goodsDetail.data.item.detail;
//    detail = detail.replaceAll(";", "</br>");
    StringBuffer sb = new StringBuffer();
    details.forEach((url){
      sb.write('<img src="$url"/>');
    });
      return  Provide<DetailsInfoProvide>(

        builder: (context,child,val){
           var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
           if(isLeft){
             return  Container(
//               child: ListView.builder(
//                 itemCount: detail.length,
//                 itemBuilder: (context, index){
//                   return Image.network(detail[index]);
//                 },
//               ),
                  child: Html(
                    data: sb.toString()
                  ),
              );
           }else{
            return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child:Text('暂时没有数据')
            );
           }
        },
      );
      
  }
}