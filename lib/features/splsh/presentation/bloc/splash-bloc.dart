import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/features/login/data/models/user-model.dart';
import 'package:inventory/features/splsh/presentation/bloc/splash-state.dart';
import 'package:inventory/features/splsh/presentation/bloc/splash-event.dart';
import 'package:inventory/core/sqllite/sqlite_api.dart';


class SplashBloc extends Bloc<BaseSplashEvent, BaseSplashState> {
  SplashBloc(BaseSplashState initialState) : super(initialState);

  @override
  Stream<BaseSplashState> mapEventToState(BaseSplashEvent event) async* {
    final driverDataDB =  await DBHelper.getData('driver_data');
    UserData userData;
//    print(driverDataDB);
    if(driverDataDB.isNotEmpty) userData=  UserData.fromJson(driverDataDB.first);


    try {

       if(event is GetSplashEvent){

        yield SplashLoadingState();



      }
    } catch (e, s) {
//      print(e);
//      print(s);
    }
  }
}
