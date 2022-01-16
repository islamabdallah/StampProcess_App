import 'package:inventory/core/models/base_model.dart';

class EmptyResultModel extends BaseModel {
  EmptyResultModel();

  factory EmptyResultModel.frommJson(json) => EmptyResultModel();
}

class RemoteResultModel<Data> extends BaseModel {
  final Data data;
  final String message;
  final bool flag;
  RemoteResultModel({required this.data,  required this.message, required this.flag});
  factory RemoteResultModel.fromJson(Map<String, dynamic> json) {
    return RemoteResultModel(
      data: json['data'],
      message: json['message'],
      flag: json['flag'],
    );
  }
}

