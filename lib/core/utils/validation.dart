bool isEmailValid(String? email) {
  // Null or empty string is invalid
  if (email == null || email.isEmpty) {
    return false;
  }
  const pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";
  final regExp = RegExp(pattern, caseSensitive: false);

  if (!regExp.hasMatch(email)) {
    //if there is no match
    return false;
  }
  return true;
}

bool isPasswordValid(String? password) {
  // null or empty string or only contains a space is invalid
  if (password == null || password.isEmpty) {
    return false;
  }
  const pattern =
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
  final regExp = RegExp(pattern, caseSensitive: true);
  if (!regExp.hasMatch(password)) {
    // if ther is no match
    return false;
  }
  return true;
}

bool isEmptyInput(String? input) {
  if (input == null) {
    return true;
  } else {
    return false;
  }
}
