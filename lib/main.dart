import 'package:api_client/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nsio_assignment/bloc/auth_cubit/auth_cubit.dart';
import 'package:nsio_assignment/screens/beer_details/beer_details.dart';
import 'package:nsio_assignment/screens/home/home.dart';
import 'package:nsio_assignment/screens/login/login.dart';
import 'package:nsio_assignment/screens/profile/profile_screen.dart';
import 'package:nsio_assignment/utils/colors.dart';
import 'package:api_client/api_client.dart';

void main() {
  runApp(
    MyApp(apiClient: ApiClient()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.apiClient}) : super(key: key);
  final ApiClient apiClient;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => apiClient,
      child: BlocProvider<AuthCubit>(
        create: (context) => AuthCubit()..isloggedIn(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'NSIO Assignment',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              bodyText2: TextStyle(
                color: CustomColors.textLight,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              headline1: TextStyle(
                color: CustomColors.textDark,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          routerConfig: _router,
        ),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (c, s) {
            if (s is AuthLoggedIn) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        );
      },
    ),
    GoRoute(
      path: BeerDetails.routeName,
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (c, s) {
            if (s is AuthLoggedIn) {
              Beer beer = state.extra as Beer;
              return BeerDetails(beer: beer);
            } else {
              return const LoginScreen();
            }
          },
        );
      },
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: ProfileScreen.routeName,
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (c, s) {
            if (s is AuthLoggedIn) {
              return const ProfileScreen();
            } else {
              return const LoginScreen();
            }
          },
        );
      },
    )
  ],
);
