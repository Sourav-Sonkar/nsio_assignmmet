import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_preferences_client/user_preferences_client.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  void isloggedIn() {
    UserPreferences.getlogged().then((value) {
      if (value) {
        emit(AuthLoggedIn());
      } else {
        emit(AuthLoggedOut());
      }
    });
  }

  void logout() {
    googleSignIn.signOut();
    googleSignIn.disconnect();
    UserPreferences.clearStorage();
    UserPreferences.setlogged(false);
    emit(AuthLoggedOut());
  }
}
