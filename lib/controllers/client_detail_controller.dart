import 'package:car_system/models/register_client_model.dart';
import 'package:get/get.dart';

class ClientDetailController extends GetxController {
  Rx<ClientModel> client = ClientModel().obs;

  @override
  void onInit() async {
    Map<dynamic, dynamic> map = Get.parameters;
    client.value = ClientModel.fromMapStringString(map);
    super.onInit();
  }
}
