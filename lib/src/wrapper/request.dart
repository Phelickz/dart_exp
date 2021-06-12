// import 'package:dart2_constant/html.dart';

import 'dart:io';

import 'package:dart_express/src/wrapper/file.dart';

class ExpressRequest {
  HttpRequest? req;

  HttpSession? sessions;
  Map<dynamic, dynamic> reqBody = {};

  Map<String, ExpressFile> files = {};

  List? currentExceptionList;

  Map<dynamic, dynamic> params = {};

  ExpressRequest(HttpRequest req) {
    this.req = req;
  }

  Map get body => reqBody;

  Uri get url => req!.uri;

  Map get query => req!.uri.queryParameters;

  String get path => req!.uri.path;

  get session => req!.session;

  HttpHeaders get headers => req!.headers;

  String get type => req!.headers.contentType!.value;

 
}
