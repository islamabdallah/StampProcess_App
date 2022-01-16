import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:inventory/core/appRepoConstants/appRepoAssets.dart';
import 'package:inventory/core/appRepoConstants/appRepoColors.dart';
import 'package:inventory/core/appRepoConstants/sizeConfig.dart';
import 'package:inventory/core/screen_utils/screen_utils.dart';
import 'package:inventory/core/ui/styles/global_colors.dart';
import 'package:inventory/core/ui/styles/global_styles.dart';
import 'package:inventory/core/ui/widgets/image_widgets/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory/core/ui/widgets/snackbar_and_toast.dart';
import 'package:inventory/core/validators/base_validator.dart';
import 'package:inventory/core/validators/min_length_validator.dart';
import 'package:inventory/core/validators/required_validator.dart';
import 'package:inventory/features/navigationDrawer/navigationDrawer.dart';
import 'package:inventory/features/trip/data/models/trip-model.dart';
import 'package:inventory/features/trip/presentation/bloc/trip_cubit.dart';
import 'package:inventory/shared/components/components.dart';
import 'package:sizer/sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class TripWidget extends StatefulWidget {
  static const String routeName = 'TripWidget';

  TripWidgetState createState() => TripWidgetState();
}

class TripWidgetState extends State<TripWidget> {

  final _key = new GlobalKey<FormFieldState<String>>();
  final shipmentNoController = TextEditingController();
  final ShipmentCheckPoint data = ShipmentCheckPoint();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ScreensHelper(context);
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: defaultAppBar(
        context: context,
        title: 'homeTitle'.tr(),
       ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: BlocConsumer<TripCubit, TripState>(
                listener: (context, state) {

                  if (state is TripSendSuccessState) {
                    // Navigator.pop(context);
                    CustomSnackbar.showSnackbar(context, 'msg'.tr());
                    shipmentNoController.clear();
                    TripCubit.get(context).restForm();
                  }
                  if (state is TripSendFailedState ){
                    // Navigator.pop(context);
                    print(state.error);
                    CustomSnackbar.showErrorSnackbar(context, state.error);
                  }
                },
                builder: (context, state) {

                  return  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                            children: [
                              Expanded(
                                child: Container(

                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.map ,
                                        color: GlobalColors.darkGreen,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'checklists'.tr(),
                                          style:GlobalStyles.textFieldStyle.copyWith(
                                            color: GlobalColors.darkGreen,
                                          ),
                                          children: <TextSpan>[
                                        TextSpan(text:" : "),
                                        TextSpan(text: TripCubit.get(context).user.checkPoint?? '' , style: TextStyle(fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: defaultFormField(
                                  controller: shipmentNoController,
                                  formKey: _key,
                                  label: 'shipment'.tr(),
                                  type: TextInputType.phone,
                                  isPassword: false,
                                  prefix: Icons.widgets ,
                                  validate: (value) {
                                    return BaseValidator.validateValue(
                                      context,
                                      value,
                                      [
                                        RequiredValidator(),
                                        MinLengthValidator(minLength: 8),

                                      ],
                                      true,
                                    );
                                  },
                                    formatInput: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    ]
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                       Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    // primary: Colors.teal,
                                    // onSurface: Colors.yellow,
                                    side: BorderSide(color: Colors.teal, width: 1),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(5))),
                                  ),
                                  onPressed: () {
                                    TripCubit.get(context).scan();
                                  },
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.settings_overscan ,
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'barcode'.tr(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(228, 237, 240, 1),
                                      borderRadius: BorderRadius.circular(ScreensHelper.fromWidth(1.5)),
                                      border: Border.all(width: 1,color: GlobalColors.primaryGreen)
                                  ),
                                  height: 45,
                                  child: Center(child:
                                  ConditionalBuilder(condition: TripCubit.get(context).scanText != null,
                                      builder: (context) =>   Text('${TripCubit.get(context).scanText}'),
                                      fallback: (context) => Text('deliveryDoc'.tr()))
                                  ),
                                ),
                              ),

                            ],
                          ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // myDivider(),
                        // Row(
                        //     children: [
                        //       Expanded(
                        //         child: Container(
                        //
                        //           child:Row(
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             children: [
                        //               Icon(
                        //                 Icons.map ,
                        //                 color: GlobalColors.darkGreen,
                        //               ),
                        //               SizedBox(
                        //                 width: 5.0,
                        //               ),
                        //               Text(
                        //                 'checklists'.tr(),
                        //                 style: GlobalStyles.textFieldStyle.copyWith(
                        //                   color: GlobalColors.darkGreen,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ]
                        // ),
                        // Container(
                        //   child: GridView.count(
                        //     shrinkWrap: true,
                        //     physics: NeverScrollableScrollPhysics(),
                        //     crossAxisCount: 2,
                        //     mainAxisSpacing: 1.0,
                        //     crossAxisSpacing: 1.0,
                        //     childAspectRatio: 1 / .25,
                        //     children: List.generate(
                        //       TripCubit.get(context).pointsList.length,
                        //           (index) =>
                        //               GestureDetector(
                        //                       onTap: () {
                        //                         TripCubit.get(context).changeCheckList(index);
                        //                       },
                        //                       child: Row(
                        //                           mainAxisAlignment: MainAxisAlignment.start,
                        //                           children:[
                        //                         TripCubit.get(context).currentIndex == index
                        //                             ? Icon(Icons.check_box,color: GlobalColors.darkGreen,)
                        //                             : Icon(Icons.check_box_outline_blank),
                        //                             SizedBox(
                        //                               width: 5.0,
                        //                             ),
                        //                        Text(TripCubit.get(context).pointsList[index],),]
                        //                       ),
                        //                     ),
                        //     ),
                        //   ),
                        //   // child: ListView.builder(
                        //   //   physics: BouncingScrollPhysics(),
                        //   //   shrinkWrap: true,
                        //   //   itemCount: TripCubit.get(context).pointsList.length,
                        //   //   itemBuilder: (context, index) {
                        //   //     return GestureDetector(
                        //   //       onTap: () {
                        //   //         TripCubit.get(context).changeCheckList(index);
                        //   //       },
                        //   //       child: ListTile(
                        //   //         leading: TripCubit.get(context).currentIndex == index
                        //   //             ? Icon(Icons.check_box,color: GlobalColors.darkGreen,)
                        //   //             : Icon(Icons.check_box_outline_blank),
                        //   //         title: Text(TripCubit.get(context).pointsList[index],),
                        //   //       ),
                        //   //     );
                        //   //   },
                        //   // ),
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          // alignment: AlignmentDirectional.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ConditionalBuilder(
                                    condition: TripCubit.get(context).images.length >= 6,
                                    builder: (context) =>
                                        TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.red,
                                        // onSurface: Colors.yellow,
                                        backgroundColor: Colors.white.withOpacity(.6),
                                        side: BorderSide(color: Colors.redAccent, width: 1),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(5))),
                                      ),
                                      onPressed: () {
                                        TripCubit.get(context).removeAllImages();
                                      },

                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                              Icons.delete ,
                                              color: Colors.red
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'removeImage'.tr(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    fallback: (context) =>
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            side: BorderSide(color: Colors.teal, width: 1),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(5))),
                                          ),
                                          onPressed: () {
                                            TripCubit.get(context).getProfileImage(context);
                                            },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                  Icons.photo_library ,
                  ),
                                              SizedBox(
                  width: 5.0,
                  ),
                                              Text(
                  'addImage'.tr(),
                  ),
                                            ],
                                          ),
                                        ),
                                  ),
                                ]
                            ),
                            // SizedBox(
                            //   width: 10.0,
                            // ),
                            // Container(
                            //   height: 50.w,
                            //   width: 35.w,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(4.0,),
                            //     border: Border.all(width: 1,color : GlobalColors.primaryGreen),
                            //   ),
                            //   child: (TripCubit.get(context).profileImage != null) ? Image(image: FileImage(TripCubit.get(context).profileImage!),
                            //     fit: BoxFit.fill,) : Container(),
                            //
                            //
                            // ),

                          ],
                        ),
                        buildGridView(context),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! TripSendLoadingState,
                          builder: (context) =>createBtn(context),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),

                      ],
                    ) ,
                  );
                },
              ),
            ),
          ),
        )
      ;

  }


  Widget createBtn(context) {
    return Center(
        child: Container(
            width: 80.w,
            height: 45,
            child: ElevatedButton(
              child: new Text('send'.tr(),),
              onPressed: () {
                if(!_key.currentState!.validate()) return;
                data.shipment =  shipmentNoController.text;
                TripCubit.get(context).addCheck(data);
                //
              },
            )));
  }


  Widget profileImageContainer(context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(
          radius: 54.0,
          backgroundColor: AppRepoColors.primaryYellow,
          child: CircleAvatar(
            radius: 50.0,
             backgroundImage:
              // TripCubit.get(context).profileImage == null ?
             // AssetImage(AppRepoAssets.imgprofile):
            FileImage(TripCubit.get(context).profileImage!),
          ),
        ),
        CircleAvatar(
          backgroundColor: AppRepoColors.appWhiteColor,
          radius: 22.0,
          child: IconButton(
            icon: CircleAvatar(
              backgroundColor: AppRepoColors.primaryYellow,
              radius: 20.0,
              child: Icon(
                Icons.camera_alt ,
                size: 16.0,
                color: AppRepoColors.blackDark,
              ),
            ),
            onPressed: () {
              // TripCubit.get(context).getProfileImage();
            },
          ),
        ),
      ],
    );
  }

  Widget buildGridView(context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(TripCubit.get(context).images.length, (index) {
        if ( TripCubit.get(context).images.length !=0 && TripCubit.get(context).images[index] is File) {
         var uploadModel = TripCubit.get(context).images[index];
          return  Card(
              clipBehavior: Clip.antiAlias,
            elevation: 4,
            child: Stack(
              // clipBehavior: Clip.,
              children: <Widget>[
                Image(image: FileImage(uploadModel),
                  fit: BoxFit.cover,
                width:100.w ,) ,

                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    width: 25,
                    height: 25,
                    child: IconButton(
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.remove_circle,
                        size: 20,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        TripCubit.get(context).removeProfileImage(index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                TripCubit.get(context).getProfileImage(context);
              },
            ),
          );
        }
      }),
    );
  }

  // Future _onAddImageClick(int index) async {
  //   setState(() {
  //     _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
  //     getFileImage(index);
  //   });
  // }













  // void _onTripButtonClicked(context) {
  //   final _isUserNameValid = validateName();
  //   final _isEmailValid = validateEmail();
  //   final _isPasswordValid = validatePassword();
  //   final _isConfirmPasswordValid = validateConfirmPassword();
  //   final _isPhoneValid = validatePhone();
  //   if (_isEmailValid && _isPasswordValid && _isUserNameValid && _isConfirmPasswordValid && _isPhoneValid) {
  //     if (  TripCubit.get(context).acceptTerms)  TripCubit.get(context).createNewUser(TripFormArgs(
  //       type: 'user',
  //       pin: '1234',
  //       email: getEmailValue(),
  //       password: getPasswordValue(),
  //       name: getNameValue(),
  //       mobile: getPhoneValue(),
  //     ));
  //     else    CustomSnackbar.showErrorSnackbar(context, 'Please check Privacy Police to create account');
  //
  //   }
  //
  //
  // }

}
