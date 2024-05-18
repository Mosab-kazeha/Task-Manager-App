import 'package:task_manager_app/config/get_it.dart';
import 'package:task_manager_app/model/auth/login_request_model.dart';
import 'package:task_manager_app/model/auth/login_response_model.dart';
import 'package:task_manager_app/model/error_model.dart';
import 'package:task_manager_app/model/exception_model.dart';
import 'package:task_manager_app/model/model.dart';
import 'package:task_manager_app/service/service.dart';

class LoginService extends Serivec {
  Future<Model> login({required LoginRequestModel user}) async {
    try {
      response = await api.dio.get(baseUrl + loginUrl, data: user.toJson());
      if (response.statusCode == 200) {
        LoginResponseModel user = LoginResponseModel.fromJson(response.data);
        writeSecureData('token', user.token);
        //? here we save the token in FlutterSecureStorage
        ///// //todo: save the user.token in flutter_secure_storage
        return user;
      } else {
        ErrorModel error = ErrorModel(error: response.statusMessage!);
        return error;
      }
    } catch (e) {
      ExceptionMode exception = ExceptionMode(exception: e.toString());
      return exception;
    }
  }
}
