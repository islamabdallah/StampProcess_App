import 'package:inventory/core/results/result.dart';
import 'package:inventory/features/login/data/models/user-model.dart';

abstract class LoginRepository {
  Future<Result> loginUser(UserData userModel);
}