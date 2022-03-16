import 'package:get/get.dart';
import '../client/client_controller.dart';
import '../cuote_month/cuotes_month_controller.dart';
import '../deudor/deudor_controller.dart';
import '../list_vehicles/list_vehicle_controller.dart';
import '../sells/sells_from_collaborator_controller.dart';
import 'dash_controller.dart';

class DashBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashController>(() => DashController());
    Get.lazyPut<ClientController>(() => ClientController());
    Get.lazyPut<DeudorController>(() => DeudorController());
    Get.lazyPut<CuotesMonthController>(() => CuotesMonthController());
    Get.lazyPut<ListVehicleController>(() => ListVehicleController());
    Get.lazyPut<SellsFromCollaboratorController>(() => SellsFromCollaboratorController());
  }
}
