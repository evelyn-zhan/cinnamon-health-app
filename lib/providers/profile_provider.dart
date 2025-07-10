import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String username = "";
  String password = "";
  String email = "";

  String usernameErrorMessage = "";
  String passwordErrorMessage = "";
  String newPasswordErrorMessage = "";
  String confirmPasswordErrorMessage = "";

  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController newPasswordC = TextEditingController();
  TextEditingController confirmNewPasswordC = TextEditingController();

  void setInfo(String loginUsername, String loginPassword, String loginEmail) {
    username = loginUsername;
    password = loginPassword;
    email = loginEmail;

    notifyListeners();
  }

  bool isDark = false, isNotificationOn = false;

  void checkUsernameValidity() {
    List<String> invalidCharacter = ["!", "@", "#", "\$", "%", "^", "&", "*", "+", "=", "|", "\\", ":", ";", ","];

    bool containInvalidCharacter = false;

    if (usernameC.text.isEmpty) {
      usernameErrorMessage = "Please enter a username";
      notifyListeners();
      return;
    }

    for (int i = 0; i < invalidCharacter.length; i++) {
      if (usernameC.text.contains(invalidCharacter[i])) {
        containInvalidCharacter = true;
        break;
      }
    }

    if (username == usernameC.text) {
      usernameErrorMessage = "Please enter a new username";
    } else if (containInvalidCharacter) {
      usernameErrorMessage = "Username must not contain special characters";
    } else {
      usernameErrorMessage = "";
    }

    notifyListeners();
  }

  void confirmCurrentPassword() {
    if (passwordC.text.isEmpty) {
      passwordErrorMessage = "Please enter your password";
    } else if (passwordC.text != password) {
      passwordErrorMessage = "Password does not match";
    } else {
      passwordErrorMessage = "";
    }
    notifyListeners();
  }

  bool changeUsername() {
    if (usernameErrorMessage == "" && passwordErrorMessage == "") {
      username = usernameC.text;
      clearController();
      resetErrorMessage();
      notifyListeners();
      return true;
    }
    return false;
  }

  void checkNewPassword () {
    if (newPasswordC.text.isEmpty) {
      newPasswordErrorMessage = "New password must not be empty";
    } else {
      newPasswordErrorMessage = "";
      if (newPasswordC.text != confirmNewPasswordC.text) {
        confirmPasswordErrorMessage = "New password does not match";
      } else {
        confirmPasswordErrorMessage = "";
      }
    }
    notifyListeners();
  }

  bool changePassword () {
    if (passwordErrorMessage == "" && confirmPasswordErrorMessage == "" && newPasswordC.text.isNotEmpty) {
      password = newPasswordC.text;
      clearController();
      resetErrorMessage();
      notifyListeners();
      return true;
    }
    return false;
  }

  void clearController () {
    usernameC.clear();
    passwordC.clear();
    newPasswordC.clear();
    confirmNewPasswordC.clear();
    notifyListeners();
  }

  void resetErrorMessage() {
    usernameErrorMessage = "";
    passwordErrorMessage = "";
    newPasswordErrorMessage = "";
    confirmPasswordErrorMessage = "";
    notifyListeners();
  }

  void switchMode(bool value) {
    isDark = value;
    notifyListeners();
  }

  void switchNotification(bool value) {
    isNotificationOn = value;
    notifyListeners();
  }
}