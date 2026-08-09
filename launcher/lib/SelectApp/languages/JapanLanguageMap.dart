import 'package:winter/winter.dart';

class JapanLanguageMap implements WinterLanguageMapper {
  String? content(String key) {
    return _lang_map[key];
  }

  final Map<String, String> _lang_map = {"hello": "こんにちは"};
}
