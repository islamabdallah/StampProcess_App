import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:inventory/core/constants.dart';
import 'package:inventory/core/screen_utils/screen_utils.dart';
import 'package:inventory/core/ui/styles/global_colors.dart';
import 'package:inventory/core/ui/styles/global_styles.dart';
import 'package:inventory/core/validators/base_validator.dart';
import 'package:inventory/core/validators/min_length_validator.dart';
import 'package:inventory/core/validators/required_validator.dart';
import 'package:inventory/shared/components/components.dart';

mixin PasswordFormMixin<T extends StatefulWidget> on State<T> {
  bool triedToSubmit = false;
  bool _validation = true;
  final _key = new GlobalKey<FormFieldState<String>>();
  final passwordController = TextEditingController();
  final FocusNode myFocusPasswordNode = FocusNode();
  bool _passwordSecure = true;

  Container buildPasswordField({
    IconData? suffixIcon,
    Function? suffixPressed,
    bool? isPassword,
    FocusNode? nextFocusNode,
    Function? onSubmitFunction,
    String? label,
    TextInputAction? textInputAction}) {
    return Container(
      // height: 50,
        child: defaultFormField(
          controller: passwordController,
          formKey: _key,
          label: label!,
          type: TextInputType.text,
          isPassword: isPassword!,
          prefix: Icons.lock,
          suffix: suffixIcon,
          suffixPressed: suffixPressed,
          validate: (value) {
            return BaseValidator.validateValue(
              context,
              value,
              [
                RequiredValidator(),
                // MinLengthValidator(minLength: MIN_PASSWORD_LENGTH)
              ],
              _validation,
            );
          },
        ));
  }

  String getPasswordValue() {
    return passwordController.text;
  }

  bool validatePassword() {
    return _key.currentState!.validate();
  }
}
