import '../model/login_response_model.dart';

enum LoginStateStatus { initial, loading, completed, fail }

class LoginState {
  LoginStateStatus loginStateStatus;
  String? error;
  LoginResponseModel? loginResponseModel;

  LoginState(
      {this.loginStateStatus = LoginStateStatus.initial,
      this.error,
      this.loginResponseModel});

  LoginState copyWith(
      {LoginStateStatus? loginStateStatus,
      String? error,
      LoginResponseModel? loginResponseModel}) {
    return LoginState(
        loginResponseModel: loginResponseModel ?? this.loginResponseModel,
        loginStateStatus: loginStateStatus ?? this.loginStateStatus,
        error: error ?? this.error);
  }
}
