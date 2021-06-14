/// JWT exception thrown when an invalid token is encountered while parsing
/// JWT token.
class JwtExpressException implements Exception {
  /// Constant constructor for a JwtExpressException.
  const JwtExpressException(this.message);

  /// Exception message
  final String message;

  @override
  String toString() => message;

  /// Invalid token exception
  static const JwtExpressException invalidToken =
      const JwtExpressException('Invalid JWT token!');

  /// Invalid token exception
  static const JwtExpressException headerNotJson =
      const JwtExpressException('Invalid JWT token: Header not JSON!');

  /// Invalid token exception
  static const JwtExpressException payloadNotJson =
      const JwtExpressException('Invalid JWT token: Payload not JSON!');

  /// Hash mismatch exception
  static const JwtExpressException hashMismatch =
      const JwtExpressException('JWT hash mismatch!');

  /// Token Expired time reached exception
  static const JwtExpressException tokenExpired =
      const JwtExpressException('JWT token expired!');

  /// Token Not Before time not yet reached exception
  static const JwtExpressException tokenNotYetAccepted =
      const JwtExpressException('JWT token not yet accepted!');

  /// Token Issued At time not yet reached exception
  static const JwtExpressException tokenNotYetIssued =
      const JwtExpressException('JWT token not yet issued!');

  /// Unallowed audience
  static const JwtExpressException audienceNotAllowed =
      const JwtExpressException('Audience not allowed!');

  /// Incorrect issuer
  static const JwtExpressException incorrectIssuer =
      const JwtExpressException('Incorrect issuer!');
}
