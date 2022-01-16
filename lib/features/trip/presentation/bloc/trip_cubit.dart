import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:inventory/core/appRepoConstants/sizeConfig.dart';
import 'package:inventory/core/models/empty_response_model.dart';
import 'package:inventory/core/services/local_storage/local_storage_service.dart';
import 'package:inventory/features/login/data/models/user-model.dart';
import 'package:inventory/features/trip/data/models/trip-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory/features/trip/data/repositories/trip-repositories-implementation.dart';
import 'package:inventory/shared/components/constants.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:meta/meta.dart';
part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {

  TripCubit() : super(TripInitialState());

  static TripCubit get(context) => BlocProvider.of(context);

  TripRepositoryImplementation repApi = TripRepositoryImplementation();
  // UserData user = UserData.fromJson(CacheHelper.getData(key: 'user'));
  UserData get user => CacheHelper.getData(key: 'user') != null ? UserData.fromJson(CacheHelper.getData(key: 'user')) : UserData() ;

  List pointsList = [];
  int currentIndex = 0;

  getCheckList() async {

    emit( TripLoadingState());
    try {
      final dataApi = await repApi.getCheckPointList();
      print(dataApi.data?.flag);
      RemoteResultModel result = dataApi.data;
        if (result.flag)
        {
          pointsList = dataApi.data?.data;
          emit(TripSuccessState()) ;
        } else {
          emit(TripFailedState(error: result.message));
        }
      //  else {
      //   print(ErrorHelper().getErrorMessage(dataApi.error));
      //   emit(TripFailedState(error: ErrorHelper().getErrorMessage(dataApi.error)));
      // }
    } catch (error) {
      print(error);
      emit(TripFailedState(error:error.toString()));
    }
  }


  addCheck(ShipmentCheckPoint registerData) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

          emit( TripSendLoadingState());
          try {
             if(position != null) {
               registerData.lat = position.latitude.toString();
               registerData.long = position.longitude.toString();
             }
             registerData.delivery = scanText?? '';
             registerData.user = uId.toString();
             registerData.checkPoint = user.checkPoint;
             registerData.image = fileImagesInBase64;
             print(registerData.toJson());
            final dataApi = await repApi.checkPoint(registerData);
            print(dataApi);
             RemoteResultModel result = dataApi.data ;

             if (result.flag)
             {
               emit(TripSendSuccessState()) ;
             } else {
               emit(TripSendFailedState(error: result.message));
             }
            //  else {
            //   print(ErrorHelper().getErrorMessage(dataApi.error));
            //   emit(TripFailedState(error: ErrorHelper().getErrorMessage(dataApi.error)));
            // }
          } catch (error) {
            print(error);
            emit(TripSendFailedState(error:error.toString()));
          }
  }


   File? profileImage;
  var picker = ImagePicker();
  String? fileInBase64;
  List images = [];
  List<String> fileImagesInBase64 = [];



  void getProfileImage(context) {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
          content: Text("cameraChose".tr()),
          elevation: 4,
          actions: [
          Row (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  // primary: Colors.teal,
                  // onSurface: Colors.yellow,
                  side: BorderSide(color: Colors.teal, width: 1),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                onPressed: () => Navigator.pop(context, ImageSource.camera),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.camera_alt ,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'camera'.tr(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 6,),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  // primary: Colors.teal,
                  // onSurface: Colors.yellow,
                  side: BorderSide(color: Colors.teal, width: 1),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                onPressed: () => Navigator.pop(context, ImageSource.gallery),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Icon(
                      Icons.photo_library ,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'gallery'.tr(),
                    ),
                  ],
                ),
              ),
            ),
          ])
          ]
      ),
    ).then((ImageSource? source) async {
      print(source.toString());
      if (source == null)  return;
       await getImageSource(source);
    });
  }

  Future<void> getImageSource(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
        maxWidth: SizeConfig.safeBlockHorizontal * 90,
        maxHeight: SizeConfig.safeBlockVertical * 70,
        imageQuality: 100
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      images.add(profileImage);
      List<int> fileInByte = profileImage!.readAsBytesSync();
       fileInBase64 = base64Encode(fileInByte);
      fileImagesInBase64.add(fileInBase64!);
      print(pickedFile.path);
      print('fileInBase64 : $fileInBase64');
      emit(ImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ImagePickedFailedState());
    }
  }

  removeProfileImage(index) {
    fileInBase64 = null;
    profileImage = null;
    images.removeAt(index);
    fileImagesInBase64.removeAt(index);
    emit(ImageRemoveSuccessState());
  }

  removeAllImages() {
    fileInBase64 = null;
    profileImage = null;
    images.clear();
    fileImagesInBase64.clear();
    emit(ImageRemoveAllSuccessState());
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeCheckList(index) {
    currentIndex = index;
    print(index);
    // suffix = isPassword ? Icons.check_box_outline_blank : Icons.check_box;

    emit(TripChangeCheckListState());
  }

  String? scanText;
  List splitList = [];
  scan() async {
    await FlutterBarcodeScanner.scanBarcode("#FF7F00", 'canceled', true, ScanMode.QR)
        .then((value) {
      if ( value == '-1' || value.isEmpty) {
        return;
      }
      splitList.add(value.toString());

      scanText = splitList.toSet().toList().join(', ');
      emit(TripScanQRState());
    });
  }

  void restForm() {
    scanText = null;
    fileInBase64 = null;
    profileImage = null;
    splitList.clear();
    images.clear();
    fileImagesInBase64.clear();
  }

  //side Menu
  String currentLanguage = translator.activeLanguageCode;
  final  List<Map<String, String>>  languages = [{'name': 'arabic', 'value': 'ar' }, {'name': 'english', 'value': 'en' }];

  void choiceLanguage(lang, context) {
    print(lang);
    translator.setNewLanguage(
      context,
      newLanguage: lang,
      remember: true,
      restart: true,
    );
    currentLanguage = lang;
    emit(LanguageChangeSuccessState());
  }

  void logOut() {
    CacheHelper.removeData(key: 'userID');
    CacheHelper.removeData(key: 'user');
    uId = null;
    emit(UserLogOutSuccessState());

  }
}
