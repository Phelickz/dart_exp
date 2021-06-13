import 'package:express_dt/src/wrapper/request.dart';

import '../../express_dt.dart';

// import '../../express_dt.dart';

class ExpressMethod {
  String? route;
  Map<String, List<Function(ExpressRequest req, ExpressResponse res)>>
      callback;
  List<Function(ExpressRequest, ExpressResponse)>? callbacks;
  String? session;
  Function()? next;

  ExpressMethod({
    Map<String, List<Function(ExpressRequest req, ExpressResponse res)>>?
      callback,
    this.route,
    this.callbacks,
    this.session,
    this.next,
  }) : callback = callback ?? {}, assert(callback != null);
}