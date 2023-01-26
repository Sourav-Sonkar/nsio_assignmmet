import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:nsio_assignment/bloc/auth_cubit/auth_cubit.dart';
import 'package:nsio_assignment/bloc/home_cubit/home_cubit.dart';
// ignore: depend_on_referenced_packages
import 'package:test/test.dart';

void main() {
  group('AuthCubit', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthLoggedIn] when isloggedIn is called',
      build: () => AuthCubit(),
      act: (cubit) => cubit.isloggedIn(isTestLogged: true),
      expect: () => [AuthLoggedIn()],
    );
  });
  group("HomeCubit", () {
    blocTest<HomeCubit, HomeState>(
        'emits [HomeLoading]and then [HomeLoaded] when getBeers is called',
        build: () => HomeCubit(ApiClient()),
        act: (cubit) => cubit.getBeers(),
        expect: () => [isA<HomeLoading>(), isA<HomeLoaded>()]);
  });
}
