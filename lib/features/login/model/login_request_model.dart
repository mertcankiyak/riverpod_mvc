
import '../../../core/model/base_model.dart';

class LoginRequestModel extends BaseModel {
  String? email;
  String? password;

  LoginRequestModel({
    this.email,
    this.password,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        email: json["email"],
        password: json["password"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return LoginRequestModel.fromJson(json);
  }
}
