import 'dart:convert';

import 'package:app_controller/app_controller.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jugger/jugger.dart' as j;

class TdConfigProvider implements ITdConfigProvider {
  @j.inject
  TdConfigProvider();

  late final Future<Map<String, String>> _cache = _readFromAssets();

  @override
  Future<int> getAppId() async => int.parse((await _cache)['apiId']!);

  @override
  Future<String> getApiHash() async => (await _cache)['apiHash']!;

  Future<Map<String, String>> _readFromAssets() async {
    final String raw =
        await rootBundle.loadString('packages/app/assets/tdlib/config.txt');

    final List<MapEntry<String, String>> entries = LineSplitter.split(raw)
        .where((String line) => line.isNotEmpty)
        .map((String line) {
      final List<String> parts = line.split(':');
      final String key = parts[0];
      final String value = parts[1];

      return MapEntry<String, String>(key, value);
    }).toList();

    assert(entries.isNotEmpty, 'config.txt is missing or not provided values!');

    return Map<String, String>.fromEntries(entries);
  }

  @override
  Future<bool> isUseTestDc() async {
    final String? useTestDcString = (await _cache)['useTestDc'];
    assert(useTestDcString == 'true' || useTestDcString == 'false');
    return useTestDcString == 'true';
  }
}
