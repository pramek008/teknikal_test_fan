extension InputValidator on String {
  //crate extension for input name minimal 3 character maksimal 50 character and must be alphabet
  bool get isValidName {
    final RegExp _nameRegExp = RegExp(
      r'^[a-zA-Z ]{3,50}$',
    );
    return _nameRegExp.hasMatch(this);
  }

  bool get isValidEmail {
    final RegExp _emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return _emailRegExp.hasMatch(this);
  }

  // bool get isValidPassword {
  //   final RegExp _passwordRegExp = RegExp(
  //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
  //   );
  //   return _passwordRegExp.hasMatch(this);
  // }
}

extension PasswordValidator on String {
  bool hasUppercase() {
    return RegExp(r'[A-Z]').hasMatch(this);
  }

  bool hasLowercase() {
    return RegExp(r'[a-z]').hasMatch(this);
  }

  bool hasDigit() {
    return RegExp(r'[0-9]').hasMatch(this);
  }

  bool hasMinLength(int minLength) {
    return this.length >= minLength;
  }
}
