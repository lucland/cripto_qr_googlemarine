import 'package:flutter/material.dart';

/// Write here every color you need use in the app to get them centralize
class CriptoQRColors {
  CriptoQRColors._();

  static const Color lightGrey = Color.fromRGBO(229, 234, 237, 1.0);
  static const Color purpleBlue = Color.fromRGBO(99, 102, 241, 1);

  static const Color white = Colors.white;
  static const Color danger110 = Color(0xFFC22B38);
  static const Color danger100 = Color(0xFFCF3845);
  static const Color systemBlue120 = Color(0xFF215FA6);
  static const Color systemBlue110 = Color(0xFF2969B2);
  static const Color systemBlue20 = Color(0xFFDEE8F4);
  static const Color background = Color(0xFFEEF2F5);
  static const Color iron100 = Color(0xFF22223B);
  static const Color iron80 = Color(0xFF464657);
  static const Color iron60 = Color(0xFF6E6E7B);
  static const Color iron40 = Color(0xFF878792);
  static const Color iron30 = Color(0xFFCBCBD1);
  static const Color iron20 = Color(0xFFE4E3EB);
  static const Color iron10 = Color(0xFFECECEF);
  static const Color iron5 = Color(0xFFFBFBFC);
  static const Color forange120 = Color(0xFFA84F33);
  static const Color forange110 = Color(0xFFBD593A);
  static const Color forange40 = Color(0xFFE8C3B7);
  static const Color forange20 = Color(0xFFFAF1ED);
  static const Color slate100 = Color(0xFF475365);
  static const Color slate110 = Color(0xFF293547);
  static const Color denim110 = Color(0xFF5B7995);
  static const Color denim100 = Color(0xFF87A2B5);
  static const Color denim20 = Color(0xFFE5EAED);
  static const Color denim5 = Color(0xFFF7F8FA);
  static const Color sand120 = Color(0xFF7C736A);
  static const Color sand20 = Color(0xFFF8F5F4);
  static const Color success20 = Color(0xFFE4F0EA);
  static const Color success100 = Color(0xFF378B63);
  static const Color success110 = Color(0xFF26703B);
  static const Color success120 = Color(0xFF1B6F47);

  static const Color warning20 = Color(0xFFFEF5E7);
  static const Color warning110 = Color(0xFFE18315);
  static const Color warning120 = Color(0xFFB25704);
  static const Color warning130 = Color(0xFF934804);

  static const Color barrierColor = Color(0x3322223B);

  /// If you have the HEX code, this help convert it to Color
  static Color fromString(String color) {
    color = '#${color.replaceAll('#', '')}';
    return Color(int.tryParse(color.replaceAll('#', '0xff')) ?? 0);
  }

  static String toHex(Color color) {
    return color.value.toRadixString(16).replaceFirst('ff', '#');
  }
}
