
import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color? defultButtomColor = HexColor("#1F59B6");
Color BorderButtomColor=HexColor('#DFDFDF');
Color defulttitletext= HexColor("354f52");
Color defultletext= HexColor("52796f");

Color? hintColor=HexColor("#A2A2A2");
Color? titleColor=HexColor("#1D2226");

