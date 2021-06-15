// import 'package:dart2_constant/convert.dart';

import 'dart:convert';

/// convert ints and floats to numbers
dynamic getValue(String value) {
  try {
    var numValue = num.parse(value);
    if (!numValue.isNaN) {
      return numValue;
    } else {
      return value;
    }
  } on FormatException {
    if (value.startsWith('[') && value.endsWith(']')) {
      return json.decode(value);
    } else if (value.startsWith('{') && value.endsWith('}')) {
      return json.decode(value);
    } else if (value.trim().toLowerCase() == 'null') {
      return null;
    } else {
      return value;
    }
  }
}

/// Converts data from urlencoded to map
dynamic buildMapFromUri(Map map, String body) {
  var parseArrayRgx = RegExp(r'^(.+)\[\]$');

  for (var keyValuePair in body.split('&')) {
    if (keyValuePair.contains('=')) {
      var equals = keyValuePair.indexOf('=');
      String key;
      key = Uri.decodeQueryComponent(keyValuePair.substring(0, equals));
      String value;
      value = Uri.decodeQueryComponent(keyValuePair.substring(equals + 1));

      if (parseArrayRgx.hasMatch(key)) {
        Match queryMatch = parseArrayRgx.firstMatch(key)!;
        key = queryMatch.group(1)!;
        if (!(map[key] is List)) {
          map[key] = [];
        }

        map[key].add(getValue(value));
      } else if (key.contains('.')) {
        // i.e. map.foo.bar => [map, foo, bar]
        List<String> keys;
        keys = key.split('.');

        Map targetMap = map[keys[0]] ?? {};
        map[keys[0]] = targetMap;
        for (var i = 1; i < keys.length; i++) {
          if (i < keys.length - 1) {
            targetMap[keys[i]] = targetMap[keys[i]] ?? {};
            targetMap = targetMap[keys[i]] as Map;
          } else {
            targetMap[keys[i]] = getValue(value);
          }
        }
      } else {
        map[key] = getValue(value);
      }
    } else {
      map[Uri.decodeQueryComponent(keyValuePair)] = true;
    }
  }
}
