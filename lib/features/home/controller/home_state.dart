import '../model/user_model.dart';

enum HomeStateStatus { initial, loading, completed, fail }

class HomeState {
  HomeStateStatus homeStateStatus;
  String? error;
  UserModel? userModel;

  HomeState(
      {this.homeStateStatus = HomeStateStatus.initial,
      this.error,
      this.userModel});

  HomeState copyWith(
      {HomeStateStatus? homeStateStatus, String? error, UserModel? userModel}) {
    return HomeState(
        userModel: userModel ?? this.userModel,
        homeStateStatus: homeStateStatus ?? this.homeStateStatus,
        error: error ?? this.error);
  }
}
