import 'dart:async';

import 'package:express_dt/express_dt.dart';
import 'package:express_dt/src/logs/log.dart';
import 'package:express_dt/src/session/cxt.dart' as ctx;
import 'package:express_dt/src/session/io.dart';
import 'package:express_dt/src/session/session.dart';

import 'com.dart';

/// JWT based session manager.
///
/// Use [io] to configure how session data is transported. Built-in options are:
/// 1. [SessionIoCookie]: Stores token in cookie
/// 2. [SessionIoAuthHeader]: Stores token in authorization header
/// 3. [SessionIoHeader]: Stores token in header
///
/// By default, [JwtSession] uses [SessionIoAuthHeader].
///
///     server() async {
///       final server = Jaguar(sessionManager: JwtSession(jwtConfig));
///       // Add routes here
///       await server.serve();
///     }
class JwtSession implements SessionManager {
  final SessionIo io;

  final ExpressJwtMap coder;

  JwtSession(ExpressJwtConfig config,
      {ExpressJwtValidationConfig? validationConfig,
      this.io: const SessionIoAuthHeader()})
      : coder = ExpressJwtMap(config, validationConfig: validationConfig);

  /// Parses session from the given [request]
  Future<Session> parse(ExpressRequest? context) async {
    String? raw = io.read(context!);
    if (raw == null) return Session.newSession({});
    Map<String, String> values;
    try {
      values = coder.decode(raw)!;
    } catch (e) {
      return Session.newSession({});
    }
    return Session(values['sid']!, values,
        DateTime.fromMillisecondsSinceEpoch(int.tryParse(values['sct']!)!));
  }

  /// Writes [response] with session details
  FutureOr<void> write(ExpressResponse? context, ExpressRequest? req) async {
    // if (req!.sessionNeedsUpdate) return null;
    Message().logInfo(req!.sessionNeedsUpdate.toString());

    // final Session? reqSes = await req!.session;
    final Session? session = await req.session;
    // Message().logInfo(reqSes!.id);

    Message().logInfo(session!.id);
    io.write(context!, coder.encode(session.asMap));
  }
}
