import 'package:riverpod/riverpod.dart';
import '../../../core/helper/shared_preferences_manager.dart';
import '../../../product/enums/shared_pref_enum.dart';
import 'landing_state.dart';

class LandingController extends StateNotifier<LandingState> {
  LandingController() : super(LandingState()) {
    alreadyUserControl();
  }

  Future<void> alreadyUserControl() async {
    state = state.copyWith(landingStateStatus: LandingStateStatus.loading);
    String? token = await SharedPreferencesManager.instance
        .getToken(key: SharedPreferencesEnum.token);
    if (token != null) {
      state =
          state.copyWith(landingStateStatus: LandingStateStatus.navigateToHome);
    } else {
      state = state.copyWith(
          landingStateStatus: LandingStateStatus.navigateToLogin);
    }
  }
}
