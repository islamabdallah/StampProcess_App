import 'package:flutter/material.dart';
import 'package:inventory/core/ui/styles/global_styles.dart';
import 'package:inventory/core/validators/base_validator.dart';
import 'package:inventory/core/validators/email_validator.dart';
import 'package:inventory/core/validators/required_validator.dart';

mixin EmailFormMixin<T extends StatefulWidget> on State<T> {
  bool triedToSubmit = false;
  bool _emailValidation = true;
  final _key = new GlobalKey<FormFieldState<String>>();
  final emailController = TextEditingController();
  final FocusNode myEmailFocusNode = FocusNode();

  TextFormField buildEmailField(
      {FocusNode? nextFocusNode,
      Function? onSubmitFunction,
      TextInputAction? textInputAction}) {
    return TextFormField(
      style: GlobalStyles.textFieldStyle,
      key: _key,
      controller: emailController,
      focusNode: myEmailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction ??
          (onSubmitFunction != null
              ? TextInputAction.go
              : TextInputAction.next),
      decoration: GlobalStyles.pidgeInputDecoration(labelText: 'Email'),
      validator: (value) {
        return BaseValidator.validateValue(
          context,
          value!,
          [RequiredValidator(), EmailValidator()],
          _emailValidation,
        );
      },
      autovalidate: false,
      onChanged: (value) {
        if (!this.triedToSubmit) return;
        _emailValidation = true;
        if (_key.currentState!.validate()) {
          setState(() {
            _emailValidation = false;
          });
        }
      },
      onFieldSubmitted: (term) {
        this.triedToSubmit = true;
        setState(() {});
        if (nextFocusNode != null) {
          nextFocusNode.requestFocus();
        }

        if (nextFocusNode == null && onSubmitFunction != null) {
          onSubmitFunction();
        }
      },
    );
  }

  String? getEmailValue() {
    return _key.currentState!.value ;
  }

  bool validateEmail() {
    this.triedToSubmit = true;
    return _key.currentState!.validate();
  }
}
