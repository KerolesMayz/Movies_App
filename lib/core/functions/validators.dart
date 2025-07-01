class Validators {
  static String? nameValidator(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Please inter your name';
    } else if (input.trim().length < 3) {
      return 'please enter a name from 3 characters';
    }
    return null;
  }

  static String? emailValidator(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Please inter your email';
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]",
    ).hasMatch(input)) {
      return 'Please inter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Please enter your password';
    } else if (input.trim().length < 8) {
      return 'Please enter password larger that 7';
    } else if (!RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(input.trim())) {
      return 'please provide a strong password';
    }
    return null;
  }

  static String? phoneValidator(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Please inter your phone number';
    } else if (input.trim().length < 10 || !input.trim().startsWith('1')) {
      return 'please enter a valid phone number';
    }
    return null;
  }
}
