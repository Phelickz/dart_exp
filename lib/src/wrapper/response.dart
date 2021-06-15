import 'package:express_dt/src/logs/log.dart';
import 'package:universal_io/io.dart';
import 'dart:convert' as j;

import 'package:express_dt/src/mime/mime_src/mime_type.dart';

import '../../express_dt.dart';

// import 'package:mime/mime.dart';

class ExpressResponse {
  SessionManager? sessionManager;
  ExpressRequest? express;
  HttpRequest? req;
  Session? _session;
  bool isClosed = false;

  Map<String, dynamic> locals = {};

  ExpressResponse(
    HttpRequest request, {
    SessionManager? manager,
    ExpressRequest? req,
    Cookie? cookie,
  }) {
    this.req = request;
    this.express = req;
    if (cookie != null) _cookies.add(cookie);
    this.sessionManager = manager;
  }

  /// Does the session need update?
  bool get sessionNeedsUpdate => _session != null && _session!.needsUpdate;

  Session get parsedSession => _session!;

  Future<Session> get session async =>
      _session ??= await sessionManager!.parse(express!);

  HttpResponse get response => req!.response;

  /// Headers
  get headers => req!.headers;

  /// Cookies
  final List<Cookie> _cookies = [];

  /// Returns cookies set in HTTP request.
  List<Cookie> get cookies => req!.cookies;

  ExpressResponse cookiess(Cookie cookie) {
    cookies.clear();
    response.cookies.add(cookie);
    print(response.cookies.toString());
    // cookies.add(cookie);
    // print(_cookies.toString());
    return this;
  }

  ExpressResponse statusCode(int statusCode) {
    response.statusCode = statusCode;
    return this;
  }

  ///Return Json data
  ExpressResponse toJson(Map<dynamic, dynamic> data,
      {Function(dynamic)? encode}) {
    // Message().logInfo(response.cookies.toString());
    // response
    // ..cookies.addAll(cookies);
    response
      ..headers.contentType = ContentType.json
      ..cookies.addAll(_cookies)
      // ..cookies.addAll(response.cookies)
      ..write(j.json.encode(data,
          toEncodable: encode ??
              (dynamic obj) =>
                  obj is DateTime ? obj.toIso8601String() : obj.toString()));

    return this;
  }

  /// Return plain text or html
  ExpressResponse send(String data) {
    response
      ..headers.contentType =
          data.contains('</') ? ContentType.html : ContentType.text
      ..write(data);

    return this;
  }

  /// Serve static  file
  Future<ExpressResponse> sendFile(String returnFile) async {
    // VirtualDirectory vd = VirtualDirectory('.');
    // vd.serveFile(File(returnFile),request);

    File file;
    file = File(returnFile);
    String? mimeType;
    mimeType = lookupMimeType(file.path);
    response.headers.contentType =
        mimeType != null ? ContentType.parse(mimeType) : ContentType.binary;
    await response.addStream(file.openRead());

    return this;
  }

  /// Close Stream
  ExpressResponse onClose({bool? session}) {
    if (session == true) {
      response.statusCode = HttpStatus.unauthorized;
      response.reasonPhrase = 'Unauthorized Session';
    }

    response.close();
    isClosed = true;
    return this;
  }

  ExpressResponse set(String name, Object value) {
    response.headers.set(name, value);
    return this;
  }
}
