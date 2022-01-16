import 'package:flutter/material.dart';
import 'base_validator.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class MinLengthValidator extends BaseValidator {
  final int minLength;

  MinLengthValidator({required this.minLength});

  @override
  String getMessage(BuildContext context) {
    // return 'This field should minimum length of '
    //     '$minLength '
    //     'characters';
    return' ${'minlength'.tr()} $minLength' ;
  }

  @override
  bool validate(String? value) {
    return value!.length == minLength;
  }
}
