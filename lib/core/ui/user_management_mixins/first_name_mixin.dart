import 'package:inventory/core/screen_utils/screen_utils.dart';
import 'package:inventory/core/ui/styles/global_colors.dart';
import 'package:inventory/core/ui/styles/global_styles.dart';
import 'package:inventory/core/validators/base_validator.dart';
import 'package:inventory/core/validators/required_validator.dart';
import 'package:flutter/material.dart';

mixin FirstNameFormMixin<T extends StatefulWidget> on State<T> {
 bool triedToSubmit = false;
 bool _validation = true;
 final _key = new GlobalKey<FormFieldState<String>>();
 final firstNameController = TextEditingController();
 final FocusNode myFocusFirstNameNode = FocusNode();

 buildFirstNameFieldWithPadding() {
   return Padding(
     padding: EdgeInsets.symmetric(horizontal: 5),
     child: Column(
       children: <Widget>[
         buildFirstNameField(),
       ],
     ),
   );
 }

 TextFormField buildFirstNameField() {
   return TextFormField(
     style: TextStyle(
         decorationThickness: 0,
         decorationColor: const Color(0xFF),
         fontSize: 14,
         height: ScreensHelper.fromHeight(0.09)),
     key: _key,
     controller: this.firstNameController,
     textInputAction: TextInputAction.go,
     keyboardType: TextInputType.text,
     focusNode: this.myFocusFirstNameNode,
     decoration: InputDecoration(
         enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(
           color: GlobalColors.greyHint,
         )),
         errorStyle: const TextStyle(height: 0.8),
         border: OutlineInputBorder(),
         isDense: true,
         labelText: 'User Name',
         labelStyle: GlobalStyles.textFieldStyle.copyWith(
           color: GlobalColors.greyHint,
         )),
     validator: (value) {
       return BaseValidator.validateValue(
         context,
         value,
         [RequiredValidator()],
         _validation,
       );
     },
     onFieldSubmitted: (term) {
       this.triedToSubmit = true;
     },
     onChanged: (value) {
       if (!this.triedToSubmit) return;
       _validation = true;
       if (_key.currentState!.validate()) {
           _validation = false;
       }
     },
   );
 }

 String? getFirstNameValue(){
   return _key.currentState!.value;
 }
}
