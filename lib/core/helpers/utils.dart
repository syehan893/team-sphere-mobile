import 'package:intl/intl.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';

class Util {
  static bool falsyChecker(dynamic value) {
    bool isEmpty = false;
    bool isZero = false;
    bool isNull = value == null;
    if (value is int || value is double || value is num) {
      isZero = value == 0 || value == 0.0;
    } else if (!isNull && value is bool) {
      return isEmpty = !value;
    } else {
      try {
        if (!isNull) isEmpty = value?.isEmpty;
      } catch (e) {
        isEmpty = false;
      }
    }
    return isNull || isEmpty || isZero;
  }

  static String getInitials({required String getString, int? limit}) =>
      getString.isNotEmpty
          ? getString
              .trim()
              .split(RegExp(' +'))
              .map((s) => s[0])
              .take(limit ?? 2)
              .join()
          : '';

  static String emptyStringOnNull(String? value) {
    if (value == null) {
      return CommonStrings.emptyString;
    }
    return value;
  }

  static String dashOnEmpty(String? value) {
    if (falsyChecker(value) || value == '') {
      return '-';
    }
    return value!;
  }

  static String toTitleCase(String text) {
    final sentences = text.split(' ');
    String result = CommonStrings.emptyString;
    if (sentences.isNotEmpty) {
      for (String word in sentences) {
        if (word.isNotEmpty) {
          final firstLetter = word[0].toUpperCase();
          final restOfLetters = word.substring(1, word.length);
          result += firstLetter + restOfLetters.toLowerCase();
          if (word != sentences.last) {
            result += CommonStrings.whiteSpace;
          }
        }
      }
    }
    return result;
  }

  static bool isDouble(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static String formatNumber(int number) {
    final NumberFormat formatter = NumberFormat('#,##0', 'id_ID');
    return formatter.format(number).replaceAll(',', '.');
  }

  static String formatDateRange(String startDate, String endDate) {
    final start = DateTime.parse(startDate);
    final end = DateTime.parse(endDate);

    final dateFormat = DateFormat('d MMM');

    final formattedStart = dateFormat.format(start);
    final formattedEnd = dateFormat.format(end);

    return '$formattedStart - $formattedEnd';
  }

  static String formatDateStandard(String startDate) {
    final start = DateTime.parse(startDate);

    final dateFormat = DateFormat('d MMM yyyy');

    final formattedStart = dateFormat.format(start);

    return formattedStart;
  }
}
