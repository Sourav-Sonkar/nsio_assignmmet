part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isGoogleLogging;
  final String errMsg;
 
  const LoginState(
      {
      this.isGoogleLogging = false,
      this.errMsg = ''});

  @override
  List<Object> get props => [isGoogleLogging, errMsg];

  @override
  String toString() =>
      'LoginState(isGoogleLogging: $isGoogleLogging, errMsg: $errMsg)';

  LoginState copyWith({
    bool? isGoogleLogging,
    String? errMsg,
  }) {
    return LoginState(
      isGoogleLogging: isGoogleLogging ?? this.isGoogleLogging,
      errMsg: errMsg ?? this.errMsg,
    );
  }
}
