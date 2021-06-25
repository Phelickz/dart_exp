import 'package:express_dt/express_dt.dart';

class ExpressSessions {
  final String secretKey;
  final SessionManager sessionManager;

  ExpressSessions(this.secretKey, this.sessionManager);
}
