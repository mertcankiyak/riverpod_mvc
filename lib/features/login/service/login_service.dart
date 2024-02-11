

import 'package:riverpod_mvc/product/extension/service_extension.dart';

import '../../../core/network/repository_manager.dart';
import '../../../product/enums/service_enum.dart';
import '../model/login_request_model.dart';
import '../model/login_response_model.dart';

abstract class ILoginService {
  RepositoryManager repositoryManager;
  ILoginService(this.repositoryManager);
  Future<LoginResponseModel?> login({required LoginRequestModel requestModel});
}

class LoginService extends ILoginService {
  LoginService(super.repositoryManager);

  @override
  Future<LoginResponseModel?> login(
      {required LoginRequestModel requestModel}) async {
    LoginResponseModel response =
        await repositoryManager.post<LoginResponseModel>(
            path: ServiceEndpointEnum.login.rawValue,
            model: LoginResponseModel(),
            data: requestModel.toJson());
    return response;
  }
}
