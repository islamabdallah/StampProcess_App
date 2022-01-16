part of 'login_cubit.dart';

abstract class LoginState {
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailedState extends LoginState {
  final String error;
  LoginFailedState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginState {}

// class LoginByGoogleState extends LoginState {}


// class LoginState extends Equatable {
//   final bool isLoading;
//   final bool isLoginButtonEnabled;
//   final String error;
//   final String token;
//
//    LoginState({
//     @required this.isLoading,
//     @required this.isLoginButtonEnabled,
//     @required this.error,
//     @required this.token,
//   });
//
//   factory LoginState.initial() {
//     return LoginState(
//       isLoading: false,
//       isLoginButtonEnabled: true,
//       error: '',
//       token: '',
//     );
//   }
//
//   factory LoginState.loading() {
//     return LoginState(
//       isLoading: true,
//       isLoginButtonEnabled: false,
//       error: '',
//       token: '',
//     );
//   }
//
//   factory LoginState.failure(String error) {
//     return LoginState(
//       isLoading: false,
//       isLoginButtonEnabled: true,
//       error: error,
//       token: '',
//     );
//   }
//
//   factory LoginState.success(String token) {
//     return LoginState(
//       isLoading: false,
//       isLoginButtonEnabled: true,
//       error: '',
//       token: token,
//     );
//   }
//
//   @override
//   String toString() =>
//       'LoginState { isLoading: $isLoading, isLoginButtonEnabled: $isLoginButtonEnabled, error: $error, token: $token }';
//
//   // TODO: implement props
//   @override
//   List<Object> get props => [isLoading,isLoginButtonEnabled,error,token];
// }



