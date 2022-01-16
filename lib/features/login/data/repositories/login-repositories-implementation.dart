import 'package:inventory/core/constants.dart';
import 'package:inventory/core/models/empty_response_model.dart';
import 'package:inventory/core/repositories/core_repository.dart';
import 'package:inventory/core/results/result.dart';
import 'package:inventory/features/login/data/models/user-model.dart';
import 'package:inventory/features/login/domain/repositories/login-repositories.dart';

class LoginRepositoryImplementation implements LoginRepository {

  @override
  Future<Result> loginUser(UserData userModel) async {
    // TODO: implement loginUser
    var data = {"pass": userModel.pass, "userName": userModel.userName, };
   final res =  await CoreRepository.request(converter: null , method: HttpMethod.POST,
       url: loginUrl, data: data,withAuthentication: false);

   if(res.hasDataOnly) {
     final response = RemoteResultModel.fromJson(res.data);
     var result;
     if (response.flag)
       {
         if(response.data.length !=0) {
           result = UserData.fromJson(response.data[0]);
           return Result(data: result);
         }
         return Result(data: response);

       } else
       {
         result = response;
         return Result(data: result);
       }

   } else
     return Result(error: res.error);
  }
}