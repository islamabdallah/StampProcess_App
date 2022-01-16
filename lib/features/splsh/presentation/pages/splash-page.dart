import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/core/constants.dart';
import 'package:inventory/core/ui/styles/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:inventory/features/login/presentation/pages/loginScreen.dart';
import 'package:inventory/features/splsh/presentation/bloc/splash-bloc.dart';
import 'package:inventory/features/splsh/presentation/bloc/splash-event.dart';
import 'package:inventory/features/splsh/presentation/bloc/splash-state.dart';
import 'package:inventory/core/screen_utils/screen_utils.dart';
import '../../../home.dart';
import 'logo_widget.dart';

class SplashWidget extends StatefulWidget {

  /// splash screen (1)
  static const routeName = 'SplashWidget';

  SplashWidgetState createState() => SplashWidgetState();
}

//new
class SplashWidgetState extends State<SplashWidget> {
  double _logoWidth = 90.0;
  SplashBloc _splashBloc = SplashBloc(BaseSplashState());

  @override
  void initState() {
    super.initState();
    // checkForUpdate();
    Future.delayed(Duration(milliseconds: 50), () {
      _logoWidth = 40.0;
      setState(() {});
    });
  }
  @override
  void dispose() {
    _splashBloc.close();
    super.dispose();
  }

  // Future<void> checkForUpdate() async {
  //   final status = await newVersion.getVersionStatus().then( (value){
  //     if (value != null && value?.canUpdate) {
  //       newVersion.showUpdateDialog(context: context,
  //         dialogTitle: "Update",
  //         versionStatus: value,
  //         dialogText: "Hazar recommends that you update to the latest version. You can keep using this app while downloading the update.",
  //         dismissAction: () => _splashBloc.add(GetSplashEvent()),
  //       );
  //     }
  //     }, onError: (err) {
  //     print(err);
  //   });
  //   _splashBloc.add(GetSplashEvent());
  // }

  @override
  Widget  build(BuildContext context) {
    // ScreenUtil.init();
    ScreensHelper(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
      DecoratedBox(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(SHHNATY_BACK_GROUND), fit: BoxFit.cover),
    ),
        child: Container(
          child: Center(
                child: AnimatedContainer(
                  width: ScreensHelper.fromWidth(_logoWidth),
                  height: ScreensHelper.fromHeight(60),
                  curve: Curves.bounceOut,
                  duration: Duration(milliseconds: 1000),
                  child: LogoWidget(),
                )
          //  child: LogoWidget(width: 90.00,),
          ),
        ),
      ),
          Positioned(
            width: ScreensHelper.width,
            height: ScreensHelper.fromHeight(0.5),
            bottom: ScreensHelper.fromHeight(4),
            child: BlocConsumer<SplashBloc, BaseSplashState>(
              bloc: _splashBloc,
              listener: (context, state) {
                if (state is SplashSuccessState) {
                  // print('${state.goToLoginPage}, ${state.goToHomePage}');
                  if (state.goToLoginPage ) {
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                  } else {
                    Navigator.pushReplacementNamed(context, HomeWidget.routeName);
                  }

                }
              },
              builder: (context, state) {

                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreensHelper.fromWidth(33)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(ScreensHelper.fromWidth(10)),
                        child: LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(GlobalColors.darkGreen),
                        )
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// end new
