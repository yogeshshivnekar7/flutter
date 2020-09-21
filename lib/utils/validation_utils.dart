class ValidationUtils {
  static bool isEmailValid(String email) {
    if ((email == null) || (email.trim().isEmpty)) {
      return false;
    }

    RegExp regExp = RegExp(
        r"^[\w!#$%&’*+/=?`{|}~^-]+(?:\.[\w!#$%&’*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]+$");
    return regExp.hasMatch(email);
  }

  static bool isValueNullOrEmpty(String value) {
    return (value == null) || (value.trim().isEmpty);
  }

  static bool isMobileNumberValid(String mobileNumber, int checkLength) {
    if ((mobileNumber == null) || (mobileNumber.trim().isEmpty)) {
      return false;
    }

    return (mobileNumber.trim().length == checkLength);
  }

  static bool isZipcodeValid(String zipcode, int checkLength) {
    if ((zipcode == null) || (zipcode
        .trim()
        .isEmpty)) {
      return false;
    }

    return (zipcode
        .trim()
        .length == checkLength);
  }
}
