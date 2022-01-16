import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:inventory/core/constants.dart';
import 'package:inventory/core/errors/bad_request_error.dart';
import 'package:inventory/core/errors/custom_error.dart';
import 'package:inventory/core/models/empty_response_model.dart';
import 'package:inventory/core/repositories/core_repository.dart';
import 'package:inventory/core/results/result.dart';
import 'package:inventory/features/trip/data/models/trip-model.dart';
import 'package:inventory/features/trip/domain/repositories/trip-repositories.dart';

class TripRepositoryImplementation implements TripRepository {

  @override
  Future<Result> checkPoint(ShipmentCheckPoint formData) async {

    final res =  await CoreRepository.request(converter: null , method: HttpMethod.POST,
        url: addShipment,data: formData.toJson(),withAuthentication: false);
    if(res.hasDataOnly) {
      final response = res.data;
      final _data = RemoteResultModel.fromJson(response);

        return Result(data: _data);
      // } else
      // {
      //   result = response.data;
      //   return Result(error: CustomError(message:result));
      // }

    } else {
      if(res.error is BadRequestError) {
        BadRequestError error=  res.error as BadRequestError;
        return Result(error: CustomError(message: error.message));
      }

      return Result(error: res.error);
    }
  }

  @override
  Future<Result> getCheckPointList() async{
    // TODO: implement getCheckPointList
    final response = await CoreRepository.request(url: getCheckPointsList, method: HttpMethod.GET, converter: null, );
    if (response.hasDataOnly) {
      final res = response.data;
      final _data = RemoteResultModel.fromJson(res);
      // if (_data.flag) {
      //   final res = _data.data;
      //   print(res);
        return Result(data: _data);
      // } else {
      //   final msg = _data.message;
      //   return Result(error: CustomError(message: msg));
      // }
    } else {
      if(response.error is BadRequestError) {
        BadRequestError error=  response.error as BadRequestError;
        return Result(error: CustomError(message: error.message));
      }

      return Result(error: response.error);

    }
  }


}