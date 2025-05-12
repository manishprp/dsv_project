import 'constants/stringconstants.dart';

class Validators {
  Validators._();
  static final _passwordExpression = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$',
  );
  static final _emailExpression = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.passwordRequired;
    } else if (!_passwordExpression.hasMatch(value)) {
      return StringConstants.passwordLimit;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.emailRequired;
    } else if (!_emailExpression.hasMatch(value)) {
      return StringConstants.inputEmail;
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.nameRequired;
    }
    return null;
  }

  static String? validateLastnameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.lastnameRequired;
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.phoneNumberMessage;
    }
    return null;
  }

  static String? confirmPasswordValidate(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return StringConstants.confirmPasswordRequired;
    } else if (password != confirmPassword) {
      return StringConstants.passwordMustMatch;
    }
    return null;
  }
}
