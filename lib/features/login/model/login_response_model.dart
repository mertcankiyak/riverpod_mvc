
import '../../../core/model/base_model.dart';

class LoginResponseModel extends BaseModel {
  String? token;

  LoginResponseModel({
    this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json["token"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "token": token,
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return LoginResponseModel.fromJson(json);
  }
}
