sealed class SignupState {}

final class SignupInitialState extends SignupState {}

final class SignupLoadingState extends SignupState {}

final class SignupSuccessState extends SignupState {}

final class SignupErrorState extends SignupState {
  final dynamic error;
  
  SignupErrorState([this.error]);
}
