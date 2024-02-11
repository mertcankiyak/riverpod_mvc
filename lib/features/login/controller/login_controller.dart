import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../../../core/helper/shared_preferences_manager.dart';
import '../../../product/enums/shared_pref_enum.dart';
import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import '../service/login_service.dart';
import 'login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController({required this.loginService}) : super(LoginState());

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  LoginService loginService;

  Future<void> login() async {
    try {
      state = state.copyWith(loginStateStatus: LoginStateStatus.loading);
      LoginResponseModel? data = await loginService.login(
          requestModel: LoginRequestModel(
              email: emailTextController.text.trim(),
              password: passwordTextController.text.trim()));
      if (data?.error == null) {
        state = state.copyWith(
            loginStateStatus: LoginStateStatus.completed,
            loginResponseModel: data);
        await SharedPreferencesManager.instance.saveToken(
            key: SharedPreferencesEnum.token, value: data?.token ?? "");
        clearForm();
      } else {
        state = state.copyWith(
            loginStateStatus: LoginStateStatus.fail,
            error: data?.error?.errorMessage);
      }
    } catch (e) {
      state = state.copyWith(
          loginStateStatus: LoginStateStatus.fail, error: e.toString());
    }
  }

  void clearForm() {
    emailTextController.clear();
    passwordTextController.clear();
  }
}
