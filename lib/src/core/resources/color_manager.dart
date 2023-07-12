import 'package:flutter/material.dart';

class ColorManager {
  // Sajha colors
  static Color primary = HexColor.fromHex("#4E9F3D");
  static Color primaryOpacity80 = HexColor.fromHex('#57D43D').withOpacity(0.8);
  static Color primaryDark = HexColor.fromHex('#1E5128');
  static Color splashColor = HexColor.fromHex('#1DA800').withOpacity(0.8);
  static Color lightGreen = HexColor.fromHex('#D8E9A8');
  static Color brightGreen = HexColor.fromHex("#57D43D");
  static Color inputGreen = HexColor.fromHex('#F0F7DE');
  static Color greenOpacity5 = HexColor.fromHex('#56B995').withOpacity(0.05);
  static Color greenNotification = HexColor.fromHex('#F6FBF9');
  static Color white = HexColor.fromHex('#ffffff');
  static Color listTile = HexColor.fromHex('#F9F8F8').withOpacity(0.5);
  static Color tileGreen = HexColor.fromHex('#EDF8EF');
  static Color blue = HexColor.fromHex('#1877F2');
  static Color red = HexColor.fromHex('#FF0000');
  static Color black = HexColor.fromHex('#000000');
  static Color blackOpacity15 = HexColor.fromHex('#000000').withOpacity(0.15);
  static Color blackOpacity19 = HexColor.fromHex('#000000').withOpacity(0.19);
  static Color blackOpacity25 = HexColor.fromHex('000000').withOpacity(0.25);
  static Color blackOpacity80 = HexColor.fromHex('#000000').withOpacity(0.80);
  static Color blackOpacity70 = HexColor.fromHex('#000000').withOpacity(0.70);
  static Color dotGrey = HexColor.fromHex('#D8D8D8');
  static Color textGrey = HexColor.fromHex('##646864');
  static Color iconGrey = HexColor.fromHex('#000000').withOpacity(0.6);
  static Color subtitleGrey = HexColor.fromHex('#838589');
  static Color borderGreen = HexColor.fromHex('#DEDEDE');
  static Color scaffolColor = HexColor.fromHex('#FFFFFF');
  static Color blueGray = HexColor.fromHex('#6699CC');
  static Color chipColor = HexColor.fromHex('#E0E0E0').withOpacity(0.5);
  static Color successBadgeBg = HexColor.fromHex('#C6F6D5');
  static Color successBadgeText = HexColor.fromHex('#22543D');
  static Color errorBadgeBg = HexColor.fromHex('#FED7D7');
  static Color errorBadgeText = HexColor.fromHex('#822727');
  static Color pendingBadgeBg = HexColor.fromHex('#E9D8FD');
  static Color pendingBadgeText = HexColor.fromHex('#44337A');
  static Color yellowFellow = HexColor.fromHex('#ffc700');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
