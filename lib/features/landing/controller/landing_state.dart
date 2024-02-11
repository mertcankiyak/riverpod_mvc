
enum LandingStateStatus { initial, loading, navigateToHome, navigateToLogin }

class LandingState {
  LandingStateStatus landingStateStatus;
  String? error;

  LandingState({
    this.landingStateStatus = LandingStateStatus.initial,
    this.error,
  });

  LandingState copyWith({
    LandingStateStatus? landingStateStatus,
    String? error,
  }) {
    return LandingState(
        landingStateStatus: landingStateStatus ?? this.landingStateStatus,
        error: error ?? this.error);
  }
}
