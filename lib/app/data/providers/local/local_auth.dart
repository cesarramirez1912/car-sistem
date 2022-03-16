import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/user_model.dart';

class LocalAuth {
  static const KEY = "userModel";

  final GetStorage _storage = Get.find();

  Future<void> setUser(User user) async {
    await _storage.write('userModel', user.toJson());
  }

  Future<void> deleteStore() async {
    await _storage.remove(KEY);
  }

  Future<User> restoreModel() async {
    final map = await _storage.read(KEY) ?? User().toJson();
    return User.fromJson(map);
  }
}
