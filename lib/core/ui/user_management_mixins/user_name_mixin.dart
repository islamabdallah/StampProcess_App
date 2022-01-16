import 'package:inventory/core/screen_utils/screen_utils.dart';
import 'package:inventory/core/ui/styles/global_styles.dart';
import 'package:inventory/core/validators/base_validator.dart';
import 'package:inventory/core/validators/required_validator.dart';
import 'package:flutter/material.dart';

mixin UserNameFormMixin<T extends StatefulWidget> on State<T> {
  bool triedToSubmit = false;
  bool _validation = true;
  final _key = new GlobalKey<FormFieldState<String>>();
  final _controller = TextEditingController();
  final FocusNode myFocusUserNameNode = FocusNode();

  Container buildUserNameField(
      {FocusNode? nextFocusNode,
      Function? onSubmitFunction,
      TextInputAction? textInputAction,
      String? label }) {
    return Container(
      // height: 50,

      child: TextFormField(

        style: GlobalStyles.textFieldStyle,
        key: _key,
        controller: this._controller,
        textInputAction: textInputAction ??
            (onSubmitFunction != null
                ? TextInputAction.go
                : TextInputAction.next),
        keyboardType: TextInputType.text,
        focusNode: this.myFocusUserNameNode,
        decoration: GlobalStyles.pidgeInputDecoration(labelText: label,prefix: Icons.person),
        validator: (value) {
          return BaseValidator.validateValue(
            context,
            value!,
            [RequiredValidator()],
            _validation,
          );
        },
        autovalidate: false,
        onFieldSubmitted: (term) {
          this.triedToSubmit = true;
          if (nextFocusNode != null) {
            nextFocusNode.requestFocus();
          }

          if (nextFocusNode == null && onSubmitFunction != null) {
            onSubmitFunction();
          }
        },
        onChanged: (value) {
          if (!this.triedToSubmit) return;
          _validation = true;
          if (_key.currentState!.validate()) {
              _validation = false;

          }
        },
      ),
    );
  }

  String getUserNameValue() {
    return _controller.text;
  }

  bool validateName() {
    return _key.currentState!.validate();
  }
}
