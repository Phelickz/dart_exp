import 'package:express_dt/express_dt.dart';
import 'package:universal_io/io.dart';

Future<dynamic>? verifySession(ExpressRequest req, ExpressResponse res,
    {String authorizationKey = 'id', bool throwOnFail = true}) async {
  final Session session = await req.session;
  final String? authId = session[authorizationKey];

  if (authId is! String || authId.isEmpty) {
    if (throwOnFail) {
      return null;
      // throw res.statusCode(HttpStatus.unauthorized).send('data');
    } else {
      return null;
    }
  }

  return authId;
}
