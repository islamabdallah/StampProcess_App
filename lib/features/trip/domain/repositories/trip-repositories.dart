import 'package:inventory/core/results/result.dart';
import 'package:inventory/features/trip/data/models/trip-model.dart';

abstract class TripRepository {
  Future<Result> checkPoint(ShipmentCheckPoint formData);
  Future<Result> getCheckPointList();
}