import 'package:flutter/foundation.dart';

extension StringExtension on String? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool get isNumber {
    try {
      num.parse(this!);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool get isBool =>
      ignoreCase('true') ||
      ignoreCase('false') ||
      ignoreCase('1') ||
      ignoreCase('0');

  bool get toBool {
    if (isBool) {
      return ignoreCase('true') || ignoreCase('1');
    } else {
      return false;
    }
  }

  int get toInt {
    if (isNumber) {
      return int.tryParse(this!) ?? 0;
    } else {
      return 0;
    }
  }

  double get toDouble {
    if (isNumber) {
      return double.tryParse(this!) ?? 0;
    } else {
      return 0;
    }
  }

  num get toNum {
    if (isNumber) {
      return num.tryParse(this!) ?? 0;
    } else {
      return 0;
    }
  }

  bool containIgnoreCase(String s2) {
    return this!.toLowerCase().contains(s2.toLowerCase()) &&
        this!.toUpperCase().contains(s2.toUpperCase());
  }

  bool ignoreCase(String? s2) {
    return this?.toLowerCase() == (s2 ?? '').toLowerCase() &&
        this?.toUpperCase() == (s2 ?? '').toUpperCase();
  }

  bool ignoreCaseIgnoreSpace(String? s2) {
    s2 ??= '';
    return removeSpace.toLowerCase() == s2.removeSpace.toLowerCase() &&
        removeSpace.toUpperCase() == s2.removeSpace.toUpperCase();
  }

  String get removeSpace => toString().replaceAll(' ', '');

  bool get isDate {
    try {
      DateTime.parse(this!);
      return true;
    } catch (e) {
      return false;
    }
  }

  DateTime? get toDate {
    try {
      return DateTime.parse(this!);
    } catch (e) {
      return null;
    }
  }

  String get capsWord => isNotNullOrEmpty
      ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}'
      : '';

  String get capsWords {
    try {
      return this!
          .split(' ')
          .map((String word) =>
              word[0].toUpperCase() + word.substring(1).toLowerCase())
          .join(' ');
    } catch (_) {
      return this ?? '';
    }
  }

  String get capsSentence => isNotNullOrEmpty
      ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}'
      : '';

  String get capsSentences {
    try {
      return this!
          .split('. ')
          .map((String sentence) =>
              sentence[0].toUpperCase() + sentence.substring(1))
          .join('. ');
    } catch (_) {
      return this!;
    }
  }

  T? toEnum<T>(List<T> values) {
    for (final T item in values) {
      final String enumString = describeEnum(item!);
      if (enumString == this) {
        return item;
      }
    }
    return null;
  }

  List<String> splitWithSeparator(String separator, {int max = 0}) {
    final List<String> result = <String>[];
    String string = this!;

    if (separator.isEmpty) {
      result.add(string);
      return result;
    }

    while (true) {
      final int index = string.indexOf(separator);
      if (index == -1 || (max > 0 && result.length >= max)) {
        result.add(string);
        break;
      }

      result.add(string.substring(0, index));
      string = this!.substring(index + separator.length);
    }

    return result;
  }
}
