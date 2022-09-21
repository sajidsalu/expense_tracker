import 'dart:convert' as convert;

import 'package:flutter/material.dart';

class ParsingUtils {
  ParsingUtils._();

  /// Get Integer from Dynamic Data
  static int intFrom(dynamic data, {int defaultValue = 0}) {
    if (null == data) return defaultValue;
    if (data is int) return data;
    if (data is double) return data.toInt();
    if (data is String) return _intFromString(data, defaultValue: defaultValue);
    return defaultValue;
  }

  /// Get Double from Dynamic Data
  static double doubleFrom(dynamic data, {double defaultValue = 0.0}) {
    if (null == data) return defaultValue;
    if (data is double) return data;
    if (data is int) return data.toDouble();
    if (data is String) return _doubleFromString(data, defaultValue: defaultValue);
    return defaultValue;
  }

  /// Get String from Dynamic Data
  static String stringFrom(dynamic data, {String defaultValue = ''}) {
    if (null == data) return defaultValue;
    if (data is String) return data;
    if (data is int) return "$data";
    if (data is double) return "$data";
    if (data is List || data is Map) {
      try {
        return convert.json.encode(data);
      } catch (e) {
        debugPrint('Parsing - Error - JSON to String : ${e.toString()}');
      }
    }
    return defaultValue;
  }

  /// Get Bool from Dynamic Data
  static bool boolFrom(dynamic data, {bool defaultValue = false}) {
    if (null == data) return defaultValue;
    if (data is bool) return data;
    if (data is int || data is double) return data == 1;
    if (data is String) {
      return ["1", "true", "yes"].contains(data.toLowerCase())
          ? true
          : ["0", "false", "no"].contains(data.toLowerCase())
          ? false
          : defaultValue;
    }
    return defaultValue;
  }

  /// Get Array from Dynamic Data
  static List<dynamic> arrayFrom(dynamic data) {
    if (null == data) return [];
    if (data is List) return data;
    if (data is String) {
      try {
        final newData = convert.jsonDecode(data);
        if (newData is List) return newData;
      } catch (_) {}
    }
    return [];
  }

  /// Get Map from Dynamic Data
  static Map<String, dynamic> mapFrom(dynamic data) {
    if (null == data) return {};
    if (data is Map) return data.map((key, value) => MapEntry(key.toString(), value));
    if (data is String) {
      try {
        final newData = convert.jsonDecode(data);
        if (newData is Map) return newData.map((key, value) => MapEntry(key.toString(), value));
      } catch (_) {}
    }
    return {};
  }

  static int _intFromString(String data, {int defaultValue = 0}) =>
      int.tryParse(data) ?? double.tryParse(data)?.toInt() ?? defaultValue;

  static double _doubleFromString(String data, {double defaultValue = 0}) =>
      double.tryParse(data) ?? int.tryParse(data)?.toDouble() ?? defaultValue;
}
