import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:inventory/shared/bloc_observer.dart';
import 'package:inventory/shared/components/constants.dart';
import 'package:inventory/shared/cubit/cubit.dart';
import 'package:inventory/shared/cubit/states.dart';
import 'package:inventory/shared/styles/themes.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'core/services/local_storage/local_storage_service.dart';
import 'features/home.dart';
import 'features/login/presentation/pages/loginScreen.dart';
import 'package:sizer/sizer.dart';

import 'features/trip/presentation/bloc/trip_cubit.dart';
import 'features/trip/presentation/pages/tripScreen.dart';


void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar','en'],
    assetsDirectory: 'assets/langs/',
    language: 'ar'
  );
  await CacheHelper.init();

  Widget widget;

  //bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  //token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'userID');
  print(uId);
  if(uId != null)
  {
    widget = TripWidget();
  } else
  {
    widget = LoginScreen();
  }
  runApp(LocalizedApp(child: MyApp(   startWidget: widget,)));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{
  // constructor
  // build
  final Widget startWidget;

  MyApp({
   required this.startWidget,
  });

  @override
  Widget build(BuildContext context)
  {
   return Sizer(
        builder: (context, orientation, deviceType) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => TripCubit(),),
              BlocProvider(create: (BuildContext context) => AppCubit(),),
            ],
            child: BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: ThemeMode.light,
                  home: startWidget,
                  localizationsDelegates: translator.delegates, // Android + iOS Delegates
                  locale: translator.activeLocale, // Active locale
                  supportedLocales: translator.locals(), // Locals list
                );
              },
            ),
          );
        }
    );

  }
}

