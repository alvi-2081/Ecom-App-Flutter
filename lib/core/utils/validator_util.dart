class ValidatorUtil {
  static RegExp emailRegex =
      RegExp(r"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");
  static RegExp passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');

  static RegExp nameRegex = RegExp(r"^[_A-z]*((-|\s)*[_A-z])+[ ]*$");

  static String? requiredValidator(String value) {
    if (value.isEmpty) {
      return "*Required";
    } else {
      return null;
    }
  }

  static String? nameValidator(String value) {
    if (value.isEmpty) {
      return "*Required";
    } else if (!nameRegex.hasMatch(value)) {
      return '*Must not contain number and special character';
    } else {
      return null;
    }
  }

  static String? emailValidator(String value) {
    if (value.isEmpty) {
      return "*Required";
    } else if (!emailRegex.hasMatch(value)) {
      return "*Email not Valid";
    } else {
      return null;
    }
  }

  // At least one lowercase letter
  static RegExp lowerCaseRegex = RegExp(r'[a-z]');

  // At least one uppercase letter
  static RegExp upperCaseRegex = RegExp(r'[A-Z]');

  // At least one number
  static RegExp numbersRegex = RegExp(r'[0-9]');

  // At least one special character
  static RegExp specialCharacterRegex = RegExp(r'[^a-zA-Z0-9]');

  static String? passwordValidator(String value) {
    // At least 6 characters
    if (value.length < 6) {
      return 'Must be at least 6 characters';
    } else if (!lowerCaseRegex.hasMatch(value)) {
      return 'Must contain at least one lowercase letter';
    } else if (!upperCaseRegex.hasMatch(value)) {
      return 'Must contain at least one uppercase letter';
    } else if (!numbersRegex.hasMatch(value)) {
      return 'Must contain at least one number';
    } else if (!specialCharacterRegex.hasMatch(value)) {
      return 'Must contain at least one special character';
    } else {
      // Password meets all criteria
      return null;
    }
  }
}
