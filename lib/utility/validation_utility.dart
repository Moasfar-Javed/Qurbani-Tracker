part of 'utility.dart';

class ValidationUtility {
  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9-]+\.[a-zA-Z]+').hasMatch(email);
  }

  static bool isMatch(String first, String other) {
    return first.trim() == other.trim();
  }

  static bool isRequiredSatisfied(String val) {
    return val.trim() != "";
  }

  static bool isOfMinAge(DateTime val) {
    final DateTime today = DateTime.now();
    final DateTime minAllowedDate = today.subtract(Duration(days: 25 * 365));
    return val.isBefore(minAllowedDate);
  }

  static bool isInCharacterRange(String val, (int, int) range) {
    return val.length >= range.$1 && val.length <= range.$2;
  }
}

class ValidationMessages {
  static String? validateRequired(String val) {
    return ValidationUtility.isRequiredSatisfied(val)
        ? null
        : tr('e_fieldRequired');
  }

  static String? validateEmail(String val) {
    return ValidationUtility.isValidEmail(val)
        ? null
        : tr('e_invalidEmailFormat');
  }

  static String? validateMatch(String val, String other) {
    return ValidationUtility.isMatch(val, other) ? null : tr('e_doesNotMatch');
  }

  static String? validateAge(DateTime val) {
    return ValidationUtility.isOfMinAge(val) ? null : tr('e_invalidAge');
  }
}
