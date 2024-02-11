import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import '../../../core/di/di.dart';
import '../../../core/helper/token_provider.dart';
import '../../../product/enums/shared_pref_enum.dart';
import '../controller/home_controller.dart';
import '../controller/home_state.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var diReference = di<StateNotifierProvider<HomeController, HomeState>>();
    return Scaffold(
      backgroundColor: const Color(0xFF122432),
      appBar: AppBar(
        backgroundColor: const Color(0xFF122432),
        title: Text(
          "HOME",
          style: context.general.textTheme.bodyLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                ref
                    .read(tokenManagerProvider)
                    .removeToken(key: SharedPreferencesEnum.token);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                    (route) => false);
              },
              icon: const Icon(
                Icons.power_settings_new_sharp,
                color: Colors.red,
              ))
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        HomeState loginState = ref.watch(diReference);
        switch (loginState.homeStateStatus) {
          case HomeStateStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case HomeStateStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case HomeStateStatus.completed:
            return _buildBody(loginState);
          case HomeStateStatus.fail:
            return Center(child: Text(loginState.error ?? ""));
        }
      }),
    );
  }

  ListView _buildBody(HomeState loginState) {
    return ListView.builder(
        itemCount: loginState.userModel?.data?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(
                    "${loginState.userModel?.data?[index].firstName} ${loginState.userModel?.data?[index].lastName}"),
                subtitle: Text("${loginState.userModel?.data?[index].email}"),
              ),
            ),
          );
        });
  }
}
