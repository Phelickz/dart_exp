import 'dart:io';
import 'dart:convert' as j;

import 'package:express_dt/src/mime/mime_src/mime_type.dart';

// import 'package:mime/mime.dart';

class ExpressResponse {
  HttpRequest? req;
  bool isClosed = false;
  Map<String, dynamic> locals = {};
  ExpressResponse(HttpRequest request) {
    this.req = request;
  }

  HttpResponse get response => req!.response;

  ExpressResponse statusCode(int statusCode) {
    response.statusCode = statusCode;
    return this;
  }


  ExpressResponse toJson(Map<dynamic, dynamic> data,{Function(dynamic)? encode}) {
    response
      ..headers.contentType = ContentType.json
      ..write(j.json.encode(data,toEncodable: encode??(dynamic obj)=>obj is DateTime?obj.toIso8601String():obj.toString()));

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
  ExpressResponse onClose() {
    response.close();
    isClosed = true;
    return this;
  }

  ExpressResponse set(String name, Object value) {
    response.headers.set(name, value);
    return this;
  }
}
