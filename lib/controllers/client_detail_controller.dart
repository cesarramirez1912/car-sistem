import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/models/sale_collaborator_model.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:get/get.dart';

class ClientDetailController extends GetxController {
  RxList<SaleCollaboratorModel> sales = <SaleCollaboratorModel>[].obs;
  SaleCollaboratorModel saleCollaboratorModel = SaleCollaboratorModel();

  Rx<Vehicle>? vehicle =  Vehicle().obs;

  RxList<ClientModel> listClients = <ClientModel>[].obs;
  Rx<ClientModel> clientModel = ClientModel().obs;

  ClientDetailController({required this.listClients, required this.sales});

  int idVenta = 0;
  int idCliente = 0;

  @override
  void onInit() async {
    Map<dynamic, dynamic> mapId = Get.parameters;
    idVenta = int.parse(mapId['idVenta']);
    idCliente = int.parse(mapId['idCliente']);
    getInformation();
    super.onInit();
  }

  void getInformation() {
    ClientModel _client =
        listClients.where((e) => e.idCliente == idCliente).toList().first;
    SaleCollaboratorModel _sale =
        sales.where((e) => e.idVenta == idVenta).toList().first;
    clientModel.value = _client;
    Vehicle _vehicle = Vehicle.fromJson(_sale.toJson());
    vehicle?.value = _vehicle;
  }
}
