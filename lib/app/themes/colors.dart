import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';

class ColorConverter {
  static Color fromHexString(String? hexString) {
    String? colorCode = hexString;
    if (!Util.falsyChecker(hexString?.contains('#'))) {
      return Color(
        int.parse(colorCode!.substring(1, 7), radix: 16) + 0xFF000000,
      );
    }
    if (hexString != null) {
      return Color(
        int.parse(hexString, radix: 16) + 0xFF000000,
      );
    }
    return Colors.transparent;
  }

  static String toHexString(Color? color) {
    Color translatedColor = color ?? Colors.transparent;
    return '#${translatedColor.value.toRadixString(16).split('ff')[1]}';
  }
}

class PColors {
  static const shades = _Shades();
  static const alert = _Alert();
  static const primary = _Primary();
  static const secondary = _Secondary();
  static const background = _Background();
  static const gradient = _Gradient();
  static const blue = _Blue();
  static const grey = _Grey();
  static const purple = _Purple();
}

class _Purple {
  const _Purple();
  Color get pale => ColorConverter.fromHexString('#F6E7FF');
}

class _Shades {
  const _Shades();
  Color get hiEm => ColorConverter.fromHexString('#000000');
  Color get loEm => ColorConverter.fromHexString('#505050');
  Color get disabled => ColorConverter.fromHexString('#808080');
  Color get stroke => ColorConverter.fromHexString('#EBEBEB');
}

class _Alert {
  const _Alert();
  Color get red700 => ColorConverter.fromHexString('#FB4D46');
  Color get red100 => ColorConverter.fromHexString('#FFEDEC');
  Color get yellow700 => ColorConverter.fromHexString('#FF9900');
  Color get yellow100 => ColorConverter.fromHexString('#FFF6E8');
  Color get green700 => ColorConverter.fromHexString('#43C4A6');
  Color get green100 => ColorConverter.fromHexString('#EDFCF9');
  Color get blue100 => ColorConverter.fromHexString('#DEE6FF');
  Color get blue700 => ColorConverter.fromHexString('#386BFF');
}

class _Primary {
  const _Primary();
  Color get p30 => ColorConverter.fromHexString('#2E397B').withOpacity(0.3);
  Color get p50 => ColorConverter.fromHexString('#2E397B').withOpacity(0.5);
  Color get p70 => ColorConverter.fromHexString('#2E397B').withOpacity(0.7);
  Color get p100 => ColorConverter.fromHexString('#2E397B');
}

class _Secondary {
  const _Secondary();
  Color get s30 => ColorConverter.fromHexString('#5C74FA').withOpacity(0.3);
  Color get s50 => ColorConverter.fromHexString('#5C74FA').withOpacity(0.5);
  Color get s70 => ColorConverter.fromHexString('#5C74FA').withOpacity(0.7);
  Color get s100 => ColorConverter.fromHexString('#5C74FA');
}

class _Background {
  const _Background();
  Color get b100 => Colors.white;
  Color get b400 => ColorConverter.fromHexString('#F2F5F4');
  Color get b350 => ColorConverter.fromHexString('#EFF1F4');
}

class _Blue {
  const _Blue();
  Color get reg => ColorConverter.fromHexString('#289386');
  Color get dark => ColorConverter.fromHexString('#1A535C');
  Color get lilBoy => ColorConverter.fromHexString('#6DA4EC');
  Color get brandeis =>
      ColorConverter.fromHexString('#006FFF').withOpacity(0.5);
  Color get maya => ColorConverter.fromHexString('#6DC2EC');
  Color get bolt =>
      ColorConverter.fromHexString('#00AAFF').withOpacity(0.5);
}

class _Grey {
  const _Grey();
  Color get reg => ColorConverter.fromHexString('#4E5764');
  Color get gainsboro => ColorConverter.fromHexString('#DADADA');
}

class _Gradient {
  const _Gradient();
  // linear-gradient(180deg, #FFECCC -2.04%, rgba(255, 236, 204, 0) 100%);
  LinearGradient get yellow => const LinearGradient(
        colors: [Color(0xFFFFECCC), Color.fromRGBO(255, 236, 204, 0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

// linear-gradient(180deg, #E5FFF9 7.18%, rgba(229, 255, 249, 0) 100%);
  LinearGradient get green => const LinearGradient(
        colors: [Color(0xFFE5FFF9), Color.fromRGBO(229, 255, 249, 0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}
