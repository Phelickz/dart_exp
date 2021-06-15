import 'dart:io';

import 'package:express_dt/express_dt.dart';
import 'package:express_dt/src/logs/log.dart';
import 'package:express_dt/src/session/cxt.dart';

import 'auth_header.dart';

/// Reads and writes session data to [Context]
abstract class SessionIo {
  /// Reads the session data from [Context]
  String? read(ExpressRequest ctx);

  /// Writes session data to [Context]
  void write(ExpressResponse ctx, String session);
}

/// Reads and writes session data from cookies
class SessionIoCookie implements SessionIo {
  /// Name of the cookie where session is stored
  final String cookieName;

  /// Path on which the session cookie shall be valid
  final String cookiePath;

  /// Constructs a new [SessionIoCookie]
  const SessionIoCookie({this.cookieName = 'jagses', this.cookiePath = '/'});

  @override

  /// Reads the session data from cookies
  String? read(ExpressRequest ctx) {
    Cookie? cook = ctx.cookies[cookieName];
    if (cook == null) return null;
    return cook.value;
  }

  @override

  /// Writes session data to cookies
  void write(ExpressResponse? ctx, String session) {
    if (ctx!.response == null) return;

    final cook = Cookie(cookieName, session);
    cook.path = cookiePath;
    Message().logInfo(cook.toString());
    // ctx.response.cookies.add(cook);
    ctx.cookiess(cook);

    Message().logInfo(ctx.response.cookies.toString());
  }
}

/// Reads and writes session data from authorization header
class SessionIoAuthHeader implements SessionIo {
  /// Scheme of authorization header where session shall be stored
  final String scheme;

  /// Constructs a new [SessionIoAuthHeader]
  const SessionIoAuthHeader({this.scheme = 'Bearer'});

  @override

  /// Reads the session data from authorization header
  String? read(ExpressRequest ctx) {
    String authHeaderStr =
        ctx.req!.headers.value(HttpHeaders.authorizationHeader)!;
    AuthHeaderItem item =
        AuthHeaderItem.fromHeaderBySchema(authHeaderStr, scheme);
    if (item == null) return null;
    return item.credentials;
  }

  @override

  /// Writes session data to authorization header
  void write(ExpressResponse ctx, String session) {
    if (ctx.response == null) return;

    final String oldHeader =
        ctx.response.headers.value(HttpHeaders.authorizationHeader)!;
    final headers = AuthHeaders.fromHeaderStr(oldHeader);
    headers.addItem(AuthHeaderItem(scheme, session));
    ctx.response.headers
        .set(HttpHeaders.authorizationHeader, headers.toString());
  }
}

/// Reads and writes session data from cookies
class SessionIoHeader implements SessionIo {
  /// Name of the header where session is stored
  final String name;

  /// Constructs a new [SessionIoHeader]
  const SessionIoHeader({this.name = 'jagses'});

  @override

  /// Reads the session data from header named by [name]
  String? read(ExpressRequest ctx) => ctx.req!.headers.value(name);

  @override

  /// Writes session data to header named by [name]
  void write(ExpressResponse ctx, String session) {
    if (ctx.response == null) return;

    ctx.response.headers.set(name, session);
  }
}
