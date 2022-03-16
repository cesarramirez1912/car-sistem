import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../providers/local/local_auth.dart';

class LocalAuthRepository {
  final LocalAuth _localAuth = Get.find();

  Future<void> setUser(User user) => _localAuth.setUser(user);

  Future<void> deleteStore() => _localAuth.deleteStore();

  Future<User> get restoremodel => _localAuth.restoreModel();
}
