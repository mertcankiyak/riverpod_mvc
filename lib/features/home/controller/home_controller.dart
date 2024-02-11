import 'package:riverpod/riverpod.dart';
import '../model/user_model.dart';
import '../service/home_service.dart';
import 'home_state.dart';

class HomeController extends StateNotifier<HomeState> {

  HomeController({required this.homeService}) : super(HomeState()){
    fetchUsers();
  }

 HomeService homeService;

  Future<void> fetchUsers() async {
    try {
      state = state.copyWith(homeStateStatus: HomeStateStatus.loading);
      UserModel? data = await homeService.fetchUsers();
     if(data?.error == null){
       state = state.copyWith(
            homeStateStatus: HomeStateStatus.completed, userModel: data);
     }else{
      state = state.copyWith(
            homeStateStatus: HomeStateStatus.fail, error: data?.error?.errorMessage);
     }
    } catch (e) {
      state = state.copyWith(
          homeStateStatus: HomeStateStatus.fail, error: e.toString());
    }
  }
}
