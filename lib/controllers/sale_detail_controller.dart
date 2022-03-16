import 'package:get/get.dart';

import '../app/data/models/sale_collaborator_model.dart';

class SaleDetailController extends GetxController {
  Rx<SaleCollaboratorModel> saleCollaborator = SaleCollaboratorModel().obs;

  @override
  void onInit() async {
    Map<dynamic, dynamic> map = Get.parameters;
    saleCollaborator.value = SaleCollaboratorModel.fromMapStringString(map);
    super.onInit();
  }
}
