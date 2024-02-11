import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/di.dart';
import '../../home/view/home_view.dart';
import '../../login/view/login_view.dart';
import '../controller/landing_controller.dart';
import '../controller/landing_state.dart';

class Landingview extends ConsumerWidget {
  Landingview({super.key});
  var diReference =
      di<StateNotifierProvider<LandingController, LandingState>>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, widget) {
      LandingState landingState = ref.watch(diReference);
      switch (landingState.landingStateStatus) {
        case LandingStateStatus.initial:
          return const Center(child: CircularProgressIndicator());
        case LandingStateStatus.loading:
          return const Center(child: CircularProgressIndicator());
        case LandingStateStatus.navigateToHome:
          return const HomeView();
        case LandingStateStatus.navigateToLogin:
          return LoginView();
      }
    });
  }
}
