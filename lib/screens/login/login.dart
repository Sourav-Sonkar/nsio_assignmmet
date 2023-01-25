import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsio_assignment/bloc/auth_cubit/auth_cubit.dart';
import 'package:nsio_assignment/bloc/login_cubit/login_cubit.dart';
import 'package:nsio_assignment/utils/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:nsio_assignment/utils/extensions/widget_extenstions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(context.read<AuthCubit>().googleSignIn),
      child: Scaffold(
        backgroundColor: CustomColors.background,
        body: Column(children: [
          const Spacer(
            flex: 2,
          ),
          Image.asset('assets/images/logo.png')
              .paddingWithSymmetry(horizontal: 46),
          Text(
            "Sign in with",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: CustomColors.pureWhite),
          ).wrapCenter().paddingForOnly(top: 88, bottom: 24),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.errMsg.isNotEmpty) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errMsg)));
              }
            },
            builder: (context, state) {
              if (state.isGoogleLogging) {
                return const CircularProgressIndicator().wrapCenter();
              }
              return ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  minimumSize:
                      MaterialStateProperty.all(const Size(double.infinity, 0)),
                ),
                onPressed: () async {
                  if (await context.read<LoginCubit>().loginWithGoogle()) {
                    context.read<AuthCubit>().isloggedIn();
                    context.go('/');
                  }
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(
                    'assets/images/google.png',
                    height: 24,
                  ),
                  Text(
                    "Google",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: CustomColors.background),
                  ).paddingForOnly(left: 24),
                ]).paddingWithSymmetry(vertical: 16),
              );
            },
          ).paddingWithSymmetry(horizontal: 18),
          const Spacer(flex: 1),
        ]),
      ),
    );
  }
}
