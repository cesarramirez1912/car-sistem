import 'package:car_system/controllers/sells_from_collaborator_controller.dart';
import 'package:get/get.dart';

class SellFromCollaboratorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellsFromCollaboratorController>(() => SellsFromCollaboratorController());
  }
}
