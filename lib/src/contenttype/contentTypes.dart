import 'package:express_dt/src/contenttype/enum.dart';

ExpressContentType expressContent (String type) {
  var types = [
    'application/x-www-form-urlencoded',
    'text/plain',
    'application/json',
    'text/html',
    'application/javascript',
    'multipart/form-data'

  ];
  for (var t in types){
    if (t.toLowerCase() == type.toLowerCase() || type.toLowerCase().contains(t.toLowerCase())){
      type = t;
      break;
    }
  };
  switch (type) {
    case 'application/x-www-form-urlencoded':
      return ExpressContentType.ApplicationFormUrlEncoded;
    case 'text/plain':
      return ExpressContentType.TextPlain;
    case 'application/json':
      return ExpressContentType.ApplicationJson;
    case 'text/html':
      return ExpressContentType.TextHtml;
    case 'application/javascript':
      return ExpressContentType.ApplicationJavascript;
    case 'multipart/form-data':
      return ExpressContentType.MultipartFormData;

    default:
      return ExpressContentType.ApplicationJson;
  }
}