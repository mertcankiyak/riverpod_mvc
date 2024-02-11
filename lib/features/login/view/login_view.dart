import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import '../../../core/di/di.dart';
import '../../../product/components/custom_textformfield.dart';
import '../../../product/ui/general_paddings.dart';
import '../../../product/ui/general_radius.dart';
import '../../home/view/home_view.dart';
import '../controller/login_controller.dart';
import '../controller/login_state.dart';

class LoginView extends ConsumerWidget with LoginFormValidator {
  LoginView({super.key});

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var diReference = di<StateNotifierProvider<LoginController, LoginState>>();

    ref.listen(diReference, (previous, next) {
      if (next.loginStateStatus == LoginStateStatus.completed) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
            (route) => false);
      } else if (next.loginStateStatus == LoginStateStatus.fail) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(next.error ?? ""),
              );
            });
      }
    });
    return Scaffold(
      backgroundColor: const Color(0xFF122432),
      appBar: AppBar(
        backgroundColor: const Color(0xFF122432),
        title: const Text("Login"),
      ),
      body: Consumer(builder: (context, ref, child) {
        LoginState loginState = ref.watch(diReference);
        switch (loginState.loginStateStatus) {
          case LoginStateStatus.initial:
            return _buildBody(context, ref, diReference);
          case LoginStateStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case LoginStateStatus.completed:
            return _buildBody(context, ref, diReference);
          case LoginStateStatus.fail:
            return _buildBody(context, ref, diReference);
        }
      }),
    );
  }

  Padding _buildBody(BuildContext context, WidgetRef ref,
      StateNotifierProvider<LoginController, LoginState> diReference) {
    return Padding(
      padding: const GeneralPadding.allMedium(),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.sized.emptySizedHeightBoxNormal,
            _headerArea(context),
            context.sized.emptySizedHeightBoxNormal,
            _emailTextField(ref, diReference),
            context.sized.emptySizedHeightBoxLow,
            _passwordTextField(ref, diReference),
            context.sized.emptySizedHeightBoxLow3x,
            _loginButton(context, ref, diReference),
          ],
        ),
      ),
    );
  }

  Column _headerArea(BuildContext context) {
    return Column(
       
      children: [
        Text(
          "WELCOME FRIENDS!",
          style: context.general.textTheme.headlineMedium?.copyWith(
              color: const Color(0xFFBDCEE8), fontWeight: FontWeight.bold),
        ),
        context.sized.emptySizedHeightBoxLow,
        Text(
          "Login",
          style: context.general.textTheme.titleSmall
              ?.copyWith(color: const Color(0xFFBDCEE8)),
        ),
      ],
    );
  }

  CustomTextFormField _emailTextField(WidgetRef ref,
      StateNotifierProvider<LoginController, LoginState> diReference) {
    return CustomTextFormField(
      controller: ref.read(diReference.notifier).emailTextController,
      isObsecure: false,
      hintText: "Email",
      validator: emailValidator,
      prefixIcon: const Icon(
        Icons.person_2_outlined,
        color: Color(0xFF717C84),
      ),
    );
  }

  CustomTextFormField _passwordTextField(WidgetRef ref,
      StateNotifierProvider<LoginController, LoginState> diReference) {
    return CustomTextFormField(
      controller: ref.read(diReference.notifier).passwordTextController,
      isObsecure: false,
      hintText: "Password",
      validator: passwordValidator,
      prefixIcon: const Icon(
        Icons.lock_outline_sharp,
        color: Color(0xFF717C84),
      ),
    );
  }

  SizedBox _loginButton(BuildContext context, WidgetRef ref,
      StateNotifierProvider<LoginController, LoginState> diReference) {
    return SizedBox(
      width: context.sized.width,
      height: context.sized.dynamicHeight(0.055),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF106AF4),
              shape: const RoundedRectangleBorder(
                  borderRadius: GeneralRadius.authTextFieldRadius())),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              ref.read(diReference.notifier).login();
            }
          },
          child: const Text("Login")),
    );
  }
}

mixin LoginFormValidator {
  String? emailValidator(String? value) {
    if ((value ?? "").isEmpty) {
      return "Email can not be empty";
    } else {
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value ?? "");
      if (emailValid) {
        return null;
      } else {
        return "Invalid email format";
      }
    }
  }

  String? passwordValidator(String? value) {
    if ((value ?? "").isEmpty) {
      return "Password can not be empty";
    } else {
      return null;
    }
  }
}
