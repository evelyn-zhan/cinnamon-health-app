import 'package:flutter/widgets.dart';
import 'package:health_mobile_app/data/users.dart';
import 'package:health_mobile_app/models/user_model.dart';
import 'package:health_mobile_app/providers/profile_provider.dart';

class LoginSignupProvider with ChangeNotifier{

  List <UserModel> users = userList;

  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  String email = "";

  TextEditingController newEmailC = TextEditingController();
  TextEditingController newUsernameC = TextEditingController();
  TextEditingController newPasswordC = TextEditingController();
  TextEditingController confirmNewPasswordC = TextEditingController();

  String usernameErrorText = "";
  String passwordErrorText = "";

  String newEmailErrorText = "";
  String newUsernameErrorText = "";
  String newPasswordErrorText = "";
  String confirmNewPasswordErrorText = "";

  bool isLoginValid = false;
  bool isSignupValid = false;

  void signup() {
    if (newEmailC.text.isEmpty) newEmailErrorText = "Please enter an email";
    else newEmailErrorText = "";

    if (newUsernameC.text.isEmpty) newUsernameErrorText = "Please enter a username";
    else {
      List <UserModel> isSameUsername = users.where((e) => e.username == newUsernameC.text).toList();
      if (isSameUsername.isNotEmpty) newUsernameErrorText = "Username already exists";
      else newUsernameErrorText = "";
    }
    
    if (newPasswordC.text.length < 8) newPasswordErrorText = "Password must be at least 8 characters long";
    else newPasswordErrorText = "";

    if (newPasswordC.text != confirmNewPasswordC.text) confirmNewPasswordErrorText = "Password does not match";
    else confirmNewPasswordErrorText = "";

    if (newUsernameErrorText != "" || newPasswordErrorText != "" || confirmNewPasswordErrorText != "") isSignupValid = false;
    else isSignupValid = true;

    print(isSignupValid);

    notifyListeners();
  }

  void addNewUser() {
    users.add(UserModel(email: newEmailC.text, username: newUsernameC.text, password: newPasswordC.text));
    notifyListeners();
  }

  void login() {
    if (usernameC.text.isEmpty) usernameErrorText = "Please enter a username";
    else {
      List <UserModel> isFound = users.where((e) => e.username == usernameC.text).toList();

      if (isFound.isEmpty) usernameErrorText = "Username does not exist";
      else {
        usernameErrorText = "";

        if (isFound[0].password != passwordC.text) passwordErrorText = "Password does not match";
        else usernameErrorText = passwordErrorText = "";
      }

      if (usernameErrorText != "" || passwordErrorText != "") isLoginValid = false;
      else {
        email = isFound[0].email;
        isLoginValid = true;
      }
    }
    notifyListeners();
  }

  void clearController () {
    usernameC.clear();
    passwordC.clear();
    newEmailC.clear();
    newUsernameC.clear();
    newPasswordC.clear();
    confirmNewPasswordC.clear();
    
    usernameErrorText = "";
    passwordErrorText = "";
    newUsernameErrorText = "";
    newPasswordErrorText = "";
    confirmNewPasswordErrorText = "";

    notifyListeners();
  }
}