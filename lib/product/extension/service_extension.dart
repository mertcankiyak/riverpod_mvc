
import '../enums/service_enum.dart';

extension ServiceEnumExtension on ServiceEndpointEnum {
  String get rawValue {
    switch (this) {
      case ServiceEndpointEnum.login:
        return "login";
      case ServiceEndpointEnum.listUser:
        return "users";
    }
  }
}
