import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tankmall/protocol/base_response.dart';


class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

class HttpUtil {
  static final HttpUtil _singleton = HttpUtil._init();
  static Dio _dio;

  static String _baseUrl = "http://47.101.180.71:8080/";

  String _statusKey = "status";
  String _codeKey = "errorCode";
  String _msgKey = "errorMsg";
  String _dataKey = "data";

  HttpUtil._init() {
    _dio = new Dio();
  }

  factory HttpUtil() {
    return _singleton;
  }

  static HttpUtil getInstance() {
    return _singleton;
  }

  void setCookie(String cookie) {
    Map<String, dynamic> _headers = new Map();
    _headers['Cookie'] = cookie;
    _dio.options.headers.addAll(_headers);
  }

  Future<BaseResponse<T>> request<T> (String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    Response response = await _dio.request(
        _baseUrl + path,
        data: data,
        options: _checkOptions(method, options),
        cancelToken: cancelToken
    );
    _printHttpLog(response);
    String _status;
    int _code;
    String _msg;
    T _data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          _status = (response.data[_statusKey] is int)
              ? response.data[_statusKey].toString()
              : response.data[_statusKey];
          _code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];
          _msg = response.data[_msgKey];
          _data = response.data[_dataKey];
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response);
          _status = (_dataMap[_statusKey] is int)
              ? _dataMap[_statusKey].toString()
              : _dataMap[_statusKey];
          _code = (_dataMap[_codeKey] is String)
              ? int.tryParse(_dataMap[_codeKey])
              : _dataMap[_codeKey];
          _msg = _dataMap[_msgKey];
          _data = _dataMap[_dataKey];
        }
        return new BaseResponse(_status, _code, _msg, _data);
      } catch (e) {
        return new Future.error(new DioError(
          response: response,
          message: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }
    return new Future.error(new DioError(
      response: response,
      message: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }

  Future<BaseResponseR<T>> requestR<T> (String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    Response response = await _dio.request(
        _baseUrl + path,
        options: _checkOptions(method, options),
        cancelToken: cancelToken
    );
    _printHttpLog(response);
    String _status;
    int _code;
    String _msg;
    T _data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          _status = (response.data[_statusKey] is int)
              ? response.data[_statusKey].toString()
              : response.data[_statusKey];
          _code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];
          _msg = response.data[_msgKey];
          _data = response.data[_dataKey];
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response);
          _status = (_dataMap[_statusKey] is int)
              ? _dataMap[_statusKey].toString()
              : _dataMap[_statusKey];
          _code = (_dataMap[_codeKey] is String)
              ? int.tryParse(_dataMap[_codeKey])
              : _dataMap[_codeKey];
          _msg = _dataMap[_msgKey];
          _data = _dataMap[_dataKey];
        }
        return new BaseResponseR(_status, _code, _msg, _data, response);
      } catch (e) {
        return new Future.error(new DioError(
          response: response,
          message: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }
    return new Future.error(new DioError(
      response: response,
      message: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }

  _checkOptions(String method, Options options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  void _printHttpLog(Response response) {
    //LogUtils.e("httpUtil", response.toString());
  }

  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return new Map();
    }
    return json.decode(response.data.toString());
  }

}