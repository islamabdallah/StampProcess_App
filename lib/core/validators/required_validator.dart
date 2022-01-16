import 'package:flutter/material.dart';
import 'base_validator.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class RequiredValidator extends BaseValidator {
  @override
  String getMessage(BuildContext context) {
    return 'required'.tr();
  }

  @override
  bool validate(String? value) {
    return value != null && value.isNotEmpty;
  }
}