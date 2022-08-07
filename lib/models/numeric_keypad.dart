import 'package:flutter/services.dart';

class NumericKeypad extends TextInputFormatter {
  static final _reg = RegExp(r'^\d+$');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return _reg.hasMatch(newValue.text) ? newValue : oldValue;
  }
}