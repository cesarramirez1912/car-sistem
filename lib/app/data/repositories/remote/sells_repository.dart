import 'package:car_system/app/data/models/cuote_detail_model.dart';
import 'package:car_system/app/data/models/refuerzo_detail_model.dart';
import 'package:car_system/app/data/models/sale_collaborator_model.dart';
import 'package:car_system/app/data/providers/remote/sells_api.dart';
import 'package:get/get.dart';

class SellsRepository{
  final SellsApi _sellsApi = Get.find<SellsApi>();

  Future<List<SaleCollaboratorModel>> requestSales(int? idCollaborator) =>_sellsApi.requestSales(idCollaborator);

  Future<String> postCuote(Map<String, dynamic> _body)=>_sellsApi.postCuote(_body);

  Future<String> postRefuerzo(Map<String, dynamic> _body) => _sellsApi.postRefuerzo(_body);

  Future<String> sellVehicle(Map<String, dynamic> _body) =>_sellsApi.sellVehicle(_body);

  Future<List<CuoteDetailModel>> requestCuotes(int? idVenta) =>_sellsApi.requestCuotes(idVenta);

  Future<List<RefuerzoDetailModel>> requestRefuerzos(int? idVenta) =>_sellsApi.requestRefuerzos(idVenta);

  Future<int> deleteVehicleSucursal(String idVehiculoSucursal) =>_sellsApi.deleteVehicle(idVehiculoSucursal);

  Future<int> deletePlan(int idPlan) =>_sellsApi.deleteVehiclePlan(idPlan);

}