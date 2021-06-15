import 'package:express_dt/src/wrapper/request.dart';

import '../../express_dt.dart';

// import '../../express_dt.dart';

class ExpressMethod {
  ///request route
  String? route;

  ///Function to be initialized in the route. Leave it blank.
  Map<String, List<Function(ExpressRequest req, ExpressResponse res)>> callback;

  ///lists of callback functions. Can be middlewares, or just one request function.
  List<Function(ExpressRequest, ExpressResponse)>? callbacks;

  ExpressMethod({
    Map<String, List<Function(ExpressRequest req, ExpressResponse res)>>?
        callback,
    this.route,
    this.callbacks,
  })  : callback = callback ?? {},
        assert(callback != null);
}
