import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/core/helper/shared_preferences_manager.dart';

//Dependency Injection ile de tanımlayabilirdim ancak bu şekilde de kullanılabildiğini göstermeyi amaçladım.
final tokenManagerProvider = Provider<SharedPreferencesManager>((ref) {
  return SharedPreferencesManager.instance;
});
