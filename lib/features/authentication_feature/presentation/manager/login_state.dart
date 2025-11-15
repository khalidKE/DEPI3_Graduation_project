sealed class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginErrorState extends LoginState {
  final dynamic error;
  
  LoginErrorState([this.error]);
}
