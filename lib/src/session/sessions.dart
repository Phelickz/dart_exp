import 'common.dart';
import 'package:logging/logging.dart';

final Logger log = Logger('requests');
class Session {
  String? secret;
  bool? resave;

  Session({this.secret, this.resave = true});

}

final Set _cookiesKeysToIgnore = {
  'samesite',
  'path',
  'domain',
  'max-age',
  'expires',
  'secure',
  'httponly'
};
