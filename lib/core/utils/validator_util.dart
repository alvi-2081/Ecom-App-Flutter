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
}
