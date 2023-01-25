import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_preferences_client/user_preferences_client.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.googleSignIn) : super(const LoginState());
  final GoogleSignIn googleSignIn;
  Future<bool> loginWithGoogle() async {
    if (state.isGoogleLogging) return false;
    emit(state.copyWith(isGoogleLogging: true));
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        UserPreferences.setlogged(true);
        UserPreferences.setUserName(googleSignInAccount.displayName ?? "");
        UserPreferences.setUserEmail(googleSignInAccount.email);
        UserPreferences.setUserPhoto(googleSignInAccount.photoUrl ?? "");
        emit(state.copyWith(isGoogleLogging: false));
        return true;
      } else {
        emit(state.copyWith(
            isGoogleLogging: false, errMsg: "Google Login Failed"));
        return false;
      }
    } catch (e) {
      emit(state.copyWith(
          isGoogleLogging: false, errMsg: "Google Login Failed"));
      return false;
    }
  }
}
