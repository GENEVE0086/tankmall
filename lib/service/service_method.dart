import 'dart:math';

import "package:dio/dio.dart";
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';


Future request(url,{formData})async{
    try{
      //print('开始获取数据...............');
      Response response;
      Dio dio = new Dio();
      dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
      if(formData==null){
        
          response = await dio.post(servicePath[url]);
      }else{
          response = await dio.post(servicePath[url],data:formData);
      }
      if(response.statusCode==200){
        return response.data;
      }else{
          throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    }catch(e){
        return print('ERROR:======>${e}');
    }
     
}

Future getRequest(url, {token}) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.json;
    dio.options.responseType = ResponseType.plain;
    response = await dio.get(url);
    return response.data;
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}


