import 'package:inventory/core/errors/socket_error.dart';
import 'package:inventory/core/errors/timeout_error.dart';
import 'package:inventory/core/errors/unauthorized_error.dart';
import 'bad_request_error.dart';
import 'base_error.dart';
import 'custom_error.dart';
import 'forbidden_error.dart';
import 'internal_server_error.dart';
import 'net_error.dart';
import 'not_found_error.dart';

class ErrorHelper {
//  final String notFoundErrorMessage = 'not_found_err';
//  final String unauthorizedErrorMessage = 'unauthorized_err';
//  final String badRequestErrorErrorMessage = 'bad_request_err';
//  final String forbiddenErrorErrorMessage = 'forbidden_err';
//  final String internalServerErrorMessage = 'server_err';
//  final String timeoutErrorErrorMessage = 'timeout_err';
//  final String unExpectedErrorMessage = 'unexpected_err';
//  final String connectionErrorMessage = 'connection_err';

  final String notFoundErrorMessage = 'Not found error';
  final String unauthorizedErrorMessage = 'Unauthorized error';
  final String badRequestErrorErrorMessage = 'Bad request error';
  final String forbiddenErrorErrorMessage = 'Forbidden error';
  final String internalServerErrorMessage = 'Internal server error';
  final String timeoutErrorErrorMessage =
      'Timeout error, it seems your internet connection is poor, Please try again';
  final String unExpectedErrorMessage = 'يوجد خطأ في البيانات حاول مره آخرى';
  final String connectionErrorMessage =
      'Connection error occurred, please check your internet connection and try again';

   String getErrorMessage( error) {
    if (error is NotFoundError) {
      return notFoundErrorMessage;
    } else if (error is UnauthorizedError) {
      return unauthorizedErrorMessage;
    } else if (error is BadRequestError) {
      return badRequestErrorErrorMessage;
    } else if (error is ForbiddenError) {
      return forbiddenErrorErrorMessage;
    } else if (error is InternalServerError) {
      return internalServerErrorMessage;
    } else if (error is TimeoutError) {
      return timeoutErrorErrorMessage;
    } else if (error is NetError || error is SocketError) {
      return connectionErrorMessage;
    } else if (error is CustomError) {
      return error.message;
    } else {
      return unExpectedErrorMessage;
    }
  }

  /// here we can add different error mapper from above
}
