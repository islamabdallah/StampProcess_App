import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:inventory/core/constants.dart';
import 'package:inventory/core/errors/base_error.dart';
import 'package:inventory/core/errors/error_helper.dart';
import 'package:inventory/core/services/local_storage/local_storage_service.dart';
import 'package:inventory/features/login/data/models/user-model.dart';
import 'package:inventory/features/login/data/repositories/login-repositories-implementation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:inventory/shared/components/constants.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginRepositoryImplementation repApi = LoginRepositoryImplementation();

  loginByEmail(UserData loginData) async{
    print(loginData.toJson());
    emit(LoginLoadingState());
          try {
            final dataApi = await repApi.loginUser(loginData);
            if(dataApi.hasDataOnly) {
              var result;
              if (dataApi.data is UserData)
                {
                  UserData user = dataApi.data;
                  updateUserToken(user);
                  emit(LoginSuccessState());
                } else {
                if(dataApi.data.data.length > 0)  result = dataApi.data.data[0];
                result = dataApi.data.data;
                emit(LoginFailedState(result.toString()));
              }
            } else {
              print(ErrorHelper().getErrorMessage(dataApi.error));
              emit(LoginFailedState(ErrorHelper().getErrorMessage(dataApi.error)));
            }

          } catch (error) {
            print(error);
            emit(LoginFailedState(ErrorHelper().getErrorMessage(error)));
          }
  }

  updateUserToken(UserData user) {
    CacheHelper.saveData(key: 'userID', value: user.id);
    CacheHelper.saveData(key: 'user', value: user.toJson());
    uId = user.id;
    print("herrrrrrr");
    print(CacheHelper.getData(key: 'user'));
    print(CacheHelper.getData(key: 'userID'));

  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

}
