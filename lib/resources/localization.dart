import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

extension BuildContextExt on BuildContext {
  String localize(
    String text, {
    Map<String, String>? params,
    int? pluralValue,
  }) {
    if (pluralValue != null) {
      return FlutterI18n.plural(this, text, pluralValue).toString();
    } else {
      return FlutterI18n.translate(
        this,
        text,
        translationParams: params,
      ).toString();
    }
  }
}
