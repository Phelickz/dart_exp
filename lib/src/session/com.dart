import 'package:universal_io/io.dart';

import '../../express_dt.dart';

/// JWT config model used to issue new JWT tokens
class ExpressJwtConfig {
  /// Issuer of the token
  final String? issuer;

  /// Audience in the token
  final List<String> audience;

  /// Maximum duration for which the token is valid
  final Duration maxAge;

  /// HS256 key
  final String hmacKey;

  const ExpressJwtConfig(this.hmacKey,
      {this.issuer,
      this.audience: const [],
      this.maxAge: const Duration(days: 1)});
}

/// Contains information to validate JWT claim set
class ExpressJwtValidationConfig {
  /// Issuer
  final String? issuer;

  /// Audience
  final String? audience;

  const ExpressJwtValidationConfig({this.issuer, this.audience});
}

class ExpressJwtMap implements MapCoder {
  final ExpressJwtConfig config;
  final ExpressJwtValidationConfig? validationConfig;
  final String subjectKey;

  ExpressJwtMap(this.config,
      {this.validationConfig: const ExpressJwtValidationConfig(),
      this.subjectKey = "id"});
  // @override
  // String encode(Map<String, String> values) {
  //   throw UnimplementedError();
  // }

  /// Validates the given JWT claim set [claimSet] against [validationConfig]
  ///
  /// Must throw exception on validation failure
  void validate(JwtExpress claimSet, {ExpressRequest? req}) {
    if (validationConfig == null) return;

    try {
      claimSet.validate(
        issuer: validationConfig!.issuer,
        audience: validationConfig!.audience,
      );
    } catch (_) {
      throw ExpressResponse(req!.req!).statusCode(HttpStatus.unauthorized);
    }
  }

  String encode(Map<String, String> values) {
    final claimSet = JwtExpress(
        issuer: config.issuer,
        subject: values[subjectKey],
        audience: config.audience,
        maxAge: config.maxAge,
        payload: values);
    return issueExpressToken(claimSet, config.hmacKey);
  }

  Map<String, String>? decode(String token) {
    try {
      print(config.hmacKey);
      final JwtExpress claimSet =
          verifyJwtHS256Signature(token, config.hmacKey);

      validate(claimSet);

      final ret = Map<String, String>.from(claimSet.payload);
      // ret[subjectKey] = claimSet.subject!;

      ret['sct'] = claimSet.issuedAt!.toUtc().millisecondsSinceEpoch.toString();
      print(claimSet.jwtId);
      return ret;
    } on JwtExpressException catch (e) {
      throw e;
    }
  }
}

/// Codes, encrypts and signs the give [Map].
///
/// Almost like [Converter<Map<String, String>, String>]
abstract class MapCoder {
  /// Encodes the given Map
  String? encode(Map<String, String> values);

  /// Decodes [value] into Map
  Map<String, String>? decode(String value);
}
