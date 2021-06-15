// Copyright (c) 2016, Ravi Teja Gudapati.
// All rights reserved.

library express_jwt;

import 'dart:collection';
import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:crypto/crypto.dart';
import 'package:express_dt/src/logs/log.dart';

import 'b64url_rfc7515.dart';
import 'claim.dart';
import 'exception.dart';
import 'secure_compare.dart';

/// Issues a HMAC SHA-256 signed JWT.
///
/// Creates a JWT using the [claimSet] for the payload and signing it using
/// the [hmacKey] with the HMAC SHA-256 algorithm.
///
/// Throws a [JsonUnsupportedObjectError] if any of the Claim Values are not
/// suitable for a JWT.
///
///     final claimSet = JwtExpress(
///       subject: 'kleak',
///       issuer: 'teja',
///       audience: <String>['example.com', 'hello.com'],
///       payload: {'k': 'v'});
///       String token = issueExpressToken(claimSet, key);
///       print(token);
String issueExpressToken(JwtExpress claimSet, String hmacKey) {
  final hmac = Hmac(sha256, hmacKey.codeUnits);

  // Use SplayTreeMap to ensure ordering in JSON: i.e. alg before typ.
  // Ordering is not required for JWT: it is deterministic and neater.
  final header = SplayTreeMap<String, String>.from(
      <String, String>{'alg': 'HS256', 'typ': 'JWT'});

  final String encHdr = B64urlEncRfc7515.encodeUtf8(json.encode(header));
  final String encPld =
      B64urlEncRfc7515.encodeUtf8(json.encode(claimSet.toJson()));
  final String data = '${encHdr}.${encPld}';
  final String encSig =
      B64urlEncRfc7515.encode(hmac.convert(data.codeUnits).bytes);
  return data + '.' + encSig;
}

/// Extracts the token from the header
///
/// The Header has to be in the `Authorization`
///
/// And the value has to be in the form `Bearer Token`
///
/// If you have yours in another form, You'll have to do it manually
String? extractTokenFromHeader(HttpHeaders headers) {
  String? value = headers.value('Authorization');
  if (value != null) {
    var list = value.split(' ');
    String token = list[1];
    return token;
  } else {
    return null;
  }
}

/// Issues a HMAC SHA-256 signed JWT.
///
/// Creates a JWT using the [claimSet] for the payload and signing it using
/// the [hmacKey] with the HMAC SHA-256 algorithm.
///
/// Throws a [JsonUnsupportedObjectError] if any of the Claim Values are not
/// suitable for a JWT.
///
///`id` is the user id you are trying to encrypt
///
///`secretKey` is your personal encryption key. Should be kept save.
String expressSign(String id, String secretKey,
    {String? issuer,
    List<String>? audience,
    Map<String, dynamic>? otherClaims,
    Duration? maxAge}) {
  final claimSet = JwtExpress(
      subject: id,
      issuer: issuer ?? null,
      audience: audience ?? null,
      otherClaims: otherClaims ?? null,
      maxAge: maxAge ?? null);

  String token = issueExpressToken(claimSet, secretKey);

  return token;
}

///Returns a map is the token is verified successfully
///
/// {"id": "id", "verified": true};
///
/// Returns null if the verification fails.
Map? expressVerify(String token, String secretKey,
    {String? issuer, String? audience}) {
  try {
    final JwtExpress claim = verifyJwtHS256Signature(token, secretKey);

    claim.validate(issuer: issuer, audience: audience);

    if (claim.subject != null && claim.subject!.isNotEmpty) {
      return {"id": claim.subject, "verified": true};
    } else {
      return null;
    }
  } on JwtExpressException {
    Message().logError('Failed to verify token');
  }
}

/// Header checking function type used by [verifyJwtHS256Signature].
typedef bool JOSEHeaderCheck(Map<String, dynamic?> joseHeader);

/// Default JOSE Header checker.
///
/// Returns true (header is ok) if the 'typ' Header Parameter is absent, or it
/// is present with the exact value of 'JWT'. Otherwise, false (header is
/// rejected).
///
/// This implementation allows [verifyJwtHS256Signature] to exactly replicate
/// its previous behaviour.
///.
/// Note: this check is more restrictive than what RFC 7519 requires, since the
/// value of 'JWT' is only a recommendation and it is supposed to be case
/// insensitive. See <https://tools.ietf.org/html/rfc7519#section-5.1>
bool defaultJWTHeaderCheck(Map<String, dynamic?> h) {
  if (!h.containsKey('typ')) {
    return true;
  }

  final dynamic? typ = h['typ'];
  return typ == 'JWT';
}

/// Verifies the signature and extracts the claim set from a JWT.
///
/// The signature is verified using the [hmacKey] with the HMAC SHA-256
/// algorithm.
///
/// The [headerCheck] is an optional function to check the header.
/// It defaults to [defaultJWTHeaderCheck].
///
/// Normally, if either the _Issued At Claim_ and/or _Expiration Time Claim_
/// are not present, default values are assigned to them.
/// This behaviour can be disabled by setting [defaultIatExp] to false.
/// See the constructor [JwtExpress] for details about what default values are
/// used and how [maxAge] is used.
///
/// Throws a [JwtExpressException] if the signature does not verify or the
/// JWT is invalid.
///
///     final decClaimSet = verifyJwtHS256Signature(token, key);
///     print(decClaimSet);
JwtExpress verifyJwtHS256Signature(String token, String hmacKey,
    {JOSEHeaderCheck? headerCheck = defaultJWTHeaderCheck,
    bool defaultIatExp = true,
    Duration maxAge = JwtExpress.defaultMaxAge}) {
  try {
    final hmac = Hmac(sha256, hmacKey.codeUnits);

    final parts = token.split('.');
    if (parts.length != 3) {
      throw JwtExpressException.invalidToken;
    }

    // Decode header and payload
    final headerString = B64urlEncRfc7515.decodeUtf8(parts[0]);
    // Check header
    final dynamic header = json.decode(headerString);
    if (header is Map) {
      // Perform any custom checks on the header
      if (headerCheck != null &&
          !headerCheck(header.cast<String, dynamic?>())) {
        throw JwtExpressException.invalidToken;
      }

      if (header['alg'] != 'HS256') {
        throw JwtExpressException.hashMismatch;
      }
    } else {
      throw JwtExpressException.headerNotJson;
    }

    // Verify signature: calculate signature and compare to token's signature
    final data = '${parts[0]}.${parts[1]}';
    final calcSig = hmac.convert(data.codeUnits).bytes;
    final tokenSig = B64urlEncRfc7515.decode(parts[2]);
    // Signature does not match calculated
    if (!secureCompareIntList(calcSig, tokenSig))
      throw JwtExpressException.hashMismatch;

    // Convert payload into a claim set
    final payloadString = B64urlEncRfc7515.decodeUtf8(parts[1]);
    final dynamic payload = json.decode(payloadString);
    if (payload is Map) {
      return JwtExpress.fromMap(payload.cast(),
          defaultIatExp: defaultIatExp, maxAge: maxAge);
    } else {
      throw JwtExpressException
          .payloadNotJson; // is JSON, but not a JSON object
    }
  } on FormatException {
    // Can be caused by:
    //   - header or payload parts are not Base64url Encoding
    //   - bytes in the header or payload are not proper UTF-8
    //   - string in header or payload cannot be parsed into JSON
    throw JwtExpressException.invalidToken;
  }
}
