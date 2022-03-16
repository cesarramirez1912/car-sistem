import 'package:get/get.dart';

import '../app/data/models/register_client_model.dart';

class ClientDetailController extends GetxController {
  Rx<ClientModel> client = ClientModel().obs;

  @override
  void onInit() async {
    Map<dynamic, dynamic> map = Get.parameters;
    client.value = ClientModel.fromMapStringString(map);
    super.onInit();
  }
}
