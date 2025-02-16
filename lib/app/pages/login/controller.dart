import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa/app/data/service/auth/service.dart';
import 'package:mesa/app/routes/route.dart';
import 'package:mesa/app/widgets/snackbar.dart';

class LoginPageController extends GetxController with StateMixin {
  static LoginPageController get to => Get.find<LoginPageController>(); // add this line
  AuthService authService = Get.find<AuthService>();

  Rx<bool> loginError = false.obs;
  Rx<bool> isRegister = false.obs;

  Rx<bool> check = false.obs;

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();

  Future<void> login() async {
    if (idController.text.isEmpty || passwordController.text.isEmpty) {
      loginError.value = true;
      return;
    }

    if (idController.text == "user" && passwordController.text == "user") {
      authService.login(idController.text, passwordController.text);
      Get.toNamed(Routes.main);
    } else {
      MESAErrorSnackBar().open("Invalid credentials");
    }
  }

  Future<void> loginForManager() async {
    if (idController.text.isEmpty || passwordController.text.isEmpty) {
      loginError.value = true;
      return;
    }

    if (idController.text == "admin" && passwordController.text == "admin") {
      authService.login(idController.text, passwordController.text);
    } else {
      MESAErrorSnackBar().open("Invalid credentials");
    }
  }

  Future<void> signUp() async {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        userNameController.text.isEmpty ||
        companyNameController.text.isEmpty ||
        signUpPasswordController.text.isEmpty ||
        passwordCheckController.text.isEmpty) {
      MESAErrorSnackBar().open("Please fill all fields");
      return;
    }

    if (signUpPasswordController.text != passwordCheckController.text) {
      MESAErrorSnackBar().open("Passwords do not match");
      return;
    }

    if (!check.value) {
      MESAErrorSnackBar().open("Please accept the terms and conditions");
      return;
    }

    fullNameController.clear();
    emailController.clear();
    userNameController.clear();
    companyNameController.clear();
    signUpPasswordController.clear();
    passwordCheckController.clear();
    check.value = false;
    isRegister.value = false;
  }
}
