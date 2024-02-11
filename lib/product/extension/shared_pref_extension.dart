
import '../enums/shared_pref_enum.dart';

extension SharedPreferencesExtension on SharedPreferencesEnum {
  String get rawValue {
    switch (this) {
      case SharedPreferencesEnum.token:
        return "token";
    }
  }
}
