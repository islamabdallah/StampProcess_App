import 'package:inventory/core/base_bloc/base_bloc.dart';
import 'package:inventory/core/errors/base_error.dart';
import 'package:inventory/features/login/data/models/user-model.dart';

class BaseSplashState {}

class SplashSuccessState extends BaseSplashState {
  final bool goToHomePage;
  final bool goToLoginPage;
  final bool goToMobilePage;
  UserData? userData;

  SplashSuccessState({this.goToLoginPage = false, this.goToHomePage = false, this.goToMobilePage = false, this.userData});
}

class SplashLoadingState extends BaseSplashState {}

class SplashInitLoading extends BaseSplashState {}

class SplashFailedState extends BaseSplashState {
  final BaseError error;
  SplashFailedState(this.error);
}

