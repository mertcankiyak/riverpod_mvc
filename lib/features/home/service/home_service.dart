
import '../../../core/network/repository_manager.dart';
import '../model/user_model.dart';

abstract class IHomeService {
  RepositoryManager repositoryManager;
  IHomeService(this.repositoryManager);
  Future<UserModel?> fetchUsers();
}

class HomeService extends IHomeService {
  HomeService(super.repositoryManager);

  @override
  Future<UserModel?> fetchUsers() async {
    UserModel? response = await repositoryManager.fetch<UserModel>(
        path: ServiceEndpointEnum.listUser.rawValue, model: UserModel());
    return response;
  }
}
