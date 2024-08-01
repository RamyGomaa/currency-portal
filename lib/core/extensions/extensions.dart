import '../resources/all_resources.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return '';
    } else {
      return this!;
    }
  }
}

extension ArabicString on String? {
  String arabicLettersOnly() {
    if (this == null) {
      return '';
    } else {
      var newStr = this!.replaceAll(RegExp(r'[a-zA-Z0-9]'), '');
      //remove any symbols from newStr

      return newStr;
    }
  }
}

extension HasArabicString on String? {
  bool hasArabicLettersOnly() {
    if (this == null) {
      return false;
    } else {
      var newStr = this!.replaceAll(RegExp(r'[a-zA-Z0-9]'), '');
      //remove any symbols from newStr

      return newStr.isNotEmpty;
    }
  }
}

extension HasAnyArabic on String? {
  bool hasAnyArabic() {
    if (this == null) {
      return false;
    } else {
      var newStr = this!.replaceAll(RegExp(r'[^\u0621-\u064A]'), '');

      return newStr.isNotEmpty;
    }
  }
}

extension HasAnyNonArabic on String? {
  bool hasAnyNonArabic() {
    if (this == null) {
      return false;
    } else {
      //remove all arabic characters so we can check if there is any non arabic characters
      var newStr = this!.replaceAll(RegExp(r'[\u0621-\u064A]'), '');
      //remove any symbols from newStr

      return newStr.isNotEmpty;
    }
  }
}

extension EnglishString on String? {
  String englishStringOnly() {
    if (this == null) {
      return '';
    } else {
      //keep only english letters and numbers
      var newStr = this!.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

      return newStr;
    }
  }
}

extension HasAnyEnglish on String? {
  bool hasAnyEnglish() {
    if (this == null) {
      return false;
    } else {
      //keep only english letters and numbers
      var newStr = this!.replaceAll(RegExp('[^a-zA-Z0-9]'), '');
      return newStr.isNotEmpty;
    }
  }
}

extension HasEnglishLetters on String? {
  ///checks if a string has any english letters
  ///returns true if it has any english letters
  ///returns false if it has no english letters
  ///returns false if the string is null
  ///it checks for letters only.
  ///*no numbers are checked*
  bool hasEnglishLetters() {
    if (this == null) {
      return false;
    } else {
      //keep only english letters and numbers
      var newStr = this!.replaceAll(RegExp('[^a-zA-Z]'), '');
      return newStr.isNotEmpty;
    }
  }
}

extension NoSymbolString on String? {
  String noSymbol() {
    if (this == null) {
      return '';
    } else {
      return this!.replaceAll(RegExp(r'[^\u0621-\u064Aa-zA-Z]'), '');
    }
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension ArabicPresentage on String? {
  ///gets the precentage of arabic letters in a string compared to other characters or signs
  ///returns a double between 0 and 1
  ///0 means no arabic letters
  ///1 means all arabic letters
  ///0.5 means half arabic letters
  ///
  ///[example]: "السلام عليكم" returns 1.0
  ///example: "السلام عليكم 123" returns 0.8
  ///example: "السلام عليكم 123 !" returns 0.75
  double arabicPresentage() {
    if (this == null || this!.isEmpty) {
      return 0.0;
    }

    int arabicCount = 0;
    int nonArabicCount = 0;
    for (int i = 0; i < this!.length; i++) {
      int codeUnit = this!.codeUnitAt(i);
      if (codeUnit >= 0x0600 && codeUnit <= 0x06FF) {
        arabicCount++;
      } else {
        nonArabicCount++;
      }
    }
    return (arabicCount / (arabicCount + nonArabicCount));
  }
}

extension NonNullInt on int? {
  int orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension DateTimeExtension on DateTime {
  String? weekdayName() {
    const Map<int, String> weekdayName = {
      1: "monday",
      2: "tuesday",
      3: "wednesday",
      4: "thursday",
      5: "friday",
      6: "saturday",
      7: "sunday"
    };
    return weekdayName[weekday];
  }
}

extension WeekDayIntExtension on int {
  String? asWeekDayName() {
    assert(this >= 1 && this <= 7);
    if (this < 1 || this > 7) return null;
    const Map<int, String> weekdayName = {
      1: "monday",
      2: "tuesday",
      3: "wednesday",
      4: "thursday",
      5: "friday",
      6: "saturday",
      7: "sunday"
    };
    return weekdayName[this];
  }
}

extension MonthIntExtension on int {
  String? toMonthName() {
    assert(this >= 1 && this <= 12);
    if (this < 1 || this > 12) return null;
    const Map<int, String> monthName = {
      1: "january",
      2: "february",
      3: "march",
      4: "april",
      5: "may",
      6: "june",
      7: "july",
      8: "august",
      9: "september",
      10: "october",
      11: "november",
      12: "december"
    };
    return monthName[this];
  }
}

extension IsComplexPassword on String {
  bool isComplex() {
    //By default, Identity requires that passwords contain an uppercase character, lowercase character, a digit, and a non-alphanumeric character. Passwords must be at least six characters long.

    return AppStrings.passwordRegEx.hasMatch(this);
  }
}
