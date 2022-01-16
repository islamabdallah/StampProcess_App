part of 'trip_cubit.dart';

abstract class TripState  {}

class TripInitialState extends TripState {}


class TripLoadingState extends TripState {}


class TripSuccessState extends TripState {

}

class TripFailedState extends TripState {
  final String? error;
  TripFailedState({this.error});
}
class TripSendLoadingState extends TripState {

}
class TripSendSuccessState extends TripState {

}

class TripSendFailedState extends TripState {
  final String? error;
  TripSendFailedState({this.error});
}

class ImagePickedSuccessState extends TripState {}

class ImagePickedFailedState extends TripState {}

class ImageRemoveSuccessState extends TripState {}
class ImageRemoveAllSuccessState extends TripState {}

class TripChangeCheckListState extends TripState {}


class TripScanQRState extends TripState {}

class UserLogOutSuccessState extends TripState {}
class LanguageChangeSuccessState extends TripState {}

// class TripState extends Equatable {
//   final bool isLoading;
//   final bool isTripButtonEnabled;
//   final String error;
//   final TripFormArgs registerFormArgs;
//
//    TripState({
//     @required this.isLoading,
//     @required this.isTripButtonEnabled,
//     @required this.error,
//      this.registerFormArgs
//   });
//
//   factory TripState.initial() {
//     return TripState(
//       isLoading: false,
//       isTripButtonEnabled: true,
//       error: '',
//       registerFormArgs: TripFormArgs(email: '', password: '', name: '', mobile: '', pin: '', type: 'user')
//     );
//   }
//
//   factory TripState.loading() {
//     return TripState(
//       isLoading: true,
//       isTripButtonEnabled: false,
//       error: '',
//     );
//   }
//
//   factory TripState.failure(String error) {
//     return TripState(
//       isLoading: false,
//       isTripButtonEnabled: true,
//       error: error,
//     );
//   }
//
//   factory TripState.success(String token) {
//     return TripState(
//       isLoading: false,
//       isTripButtonEnabled: true,
//       error: '',
//
//     );
//   }
//
//   @override
//   String toString() =>
//       'TripState { isLoading: $isLoading, isTripButtonEnabled: $isTripButtonEnabled, error: $error,  }';
//
//   // TODO: implement props
//   @override
//   List<Object> get props => [isLoading,isTripButtonEnabled,error,registerFormArgs];
// }



