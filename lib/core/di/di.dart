import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod/riverpod.dart';
import '../../features/home/controller/home_controller.dart';
import '../../features/home/controller/home_state.dart';
import '../../features/home/service/home_service.dart';
import '../../features/landing/controller/landing_controller.dart';
import '../../features/landing/controller/landing_state.dart';
import '../../features/login/controller/login_controller.dart';
import '../../features/login/controller/login_state.dart';
import '../../features/login/service/login_service.dart';
import '../network/network_manager.dart';
import '../network/repository_manager.dart';

final di = GetIt.instance;

Future<void> setupDi() async {

  //Dio Instance
  di.registerSingleton<Dio>(NetworkManager.instance.dio);

  //Network Instance
  di.registerSingleton<NetworkManager>(NetworkManager.instance);

  //RepositoryManager
  di.registerSingleton<RepositoryManager>(
      RepositoryManager(dio: di<NetworkManager>().dio));

  //SERVICES
  //LoginService
  di.registerSingleton<LoginService>(LoginService(di<RepositoryManager>()));
  //HomeService
  di.registerSingleton<HomeService>(HomeService(di<RepositoryManager>()));

  //NOTIFIERS
  //LoginStateNotifier
  di.registerSingleton(StateNotifierProvider<LoginController, LoginState>(
      (ref) => LoginController(loginService: di<LoginService>())));
  //LandingStateNotifier
  di.registerSingleton(StateNotifierProvider<LandingController, LandingState>(
      (ref) => LandingController()));
  //HomeStateNotifier
  di.registerSingleton(StateNotifierProvider<HomeController, HomeState>(
      (ref) => HomeController(homeService: di<HomeService>())));
}
