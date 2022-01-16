import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:inventory/core/ui/user_management_mixins/password_mixin.dart';
import 'package:inventory/core/ui/user_management_mixins/user_name_mixin.dart';
import 'package:inventory/core/ui/widgets/snackbar_and_toast.dart';
import 'package:inventory/core/appRepoConstants/appRepoAssets.dart';
import 'package:inventory/features/home.dart';
import 'package:inventory/features/login/data/models/user-model.dart';
import 'package:inventory/features/login/presentation/bloc/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/features/trip/presentation/pages/tripScreen.dart';
import 'package:inventory/shared/components/components.dart';
import 'package:sizer/sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  LoginScreenState createState() => LoginScreenState();
}

// with EmailFormMixin, PasswordFormMixin
class LoginScreenState extends State<LoginScreen> with UserNameFormMixin, PasswordFormMixin {
  UserData loginArgs = UserData(userName: '',pass: '');

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("repppppBuildContext");

    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child:  Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  height: 100.h,
                  padding: EdgeInsets.all(20),
                  child: BlocConsumer<LoginCubit, LoginState> (
                    builder: (context, state) {
                      print("reppppp");
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70.w,
                              child: Image.asset(AppRepoAssets.amtyBlack,fit: BoxFit.cover,)),
                          SizedBox(
                            height: 6.h,
                          ),
                          emailField(),
                          SizedBox(
                            height: 20,
                          ),
                          passwordField(context),

                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                           builder: (context) =>signInBtn(context),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),

                          SizedBox(
                            height: 2.h,
                          ),
                          // SignUpBtn()
                        ],
                      );

                    },
                    listener: (context, state) {

                      if (state is LoginSuccessState) {
                        // Navigator.pop(context);
                        navigateAndFinish(context,TripWidget());
                      }
                      if (state is LoginFailedState ){
                        // Navigator.pop(context);
                        print(state.error);
                        CustomSnackbar.showErrorSnackbar(context, state.error);
                        //

                      }
                    },

                  ),
                ),

              ),
            ))),
    );
  }


  Widget emailField() {
    return Container(
        child: buildUserNameField(
          label: 'User'.tr(),
            nextFocusNode: myFocusPasswordNode,
            ));
  }

  Widget passwordField(context) {
    return Container(
      child: buildPasswordField(
        label: 'password'.tr(),
          suffixIcon: LoginCubit.get(context).suffix,
          isPassword: LoginCubit.get(context).isPassword,
          suffixPressed:  LoginCubit.get(context).changePasswordVisibility,
          onSubmitFunction: () {
            final _isEmailValid = validateName();
            final _isPasswordValid = validatePassword();
            if (_isEmailValid && _isPasswordValid) {
              loginArgs.userName = getUserNameValue();
              loginArgs.pass = getPasswordValue();
              LoginCubit.get(context).loginByEmail(loginArgs);
            }
          },
          textInputAction: TextInputAction.go),
    );
  }

  Widget signInBtn(context) {
    return Center(
        child: Container(
            width: 80.w,
            height: 45,
            child: ElevatedButton(
              // style: GlobalStyles.BTN_STYLE_YELLOW,
              style: ButtonStyle(

              ),
              child: new Text('login'.tr()),
              onPressed: () {
                final _isEmailValid = validateName();
                final _isPasswordValid = validatePassword();
                print(_isEmailValid);
                print(_isPasswordValid);
                if (_isEmailValid && _isPasswordValid) {
                  loginArgs.userName = getUserNameValue();
                  loginArgs.pass = getPasswordValue();
                  LoginCubit.get(context).loginByEmail(loginArgs);
                }
                //
              },
            )));
  }

}
