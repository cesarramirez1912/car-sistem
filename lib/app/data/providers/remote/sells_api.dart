import 'package:car_system/app/core/utils/user_storage_controller.dart';
import 'package:car_system/app/data/models/cuote_detail_model.dart';
import 'package:car_system/app/data/models/refuerzo_detail_model.dart';
import 'package:car_system/app/data/models/sale_collaborator_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../../../rest.dart';

class SellsApi {
  final Dio _dio = Get.find<Dio>();
  final UserStorageController _user = Get.find();

  Future<List<SaleCollaboratorModel>> requestSales(int? idCollaborator) async {
    final Response response =
        await _dio.get(Rest.SELLS_COLLABORATOR + idCollaborator.toString(),
            options: Options(
              headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
            ));
    return (response.data['response'] as List)
        .map((e) => SaleCollaboratorModel.fromJson(e))
        .toList();
  }

  Future<String> postCuote(Map<String, dynamic> _body) async {
    final Response response = await _dio.post(Rest.SELLS_CUOTE,
        data: _body,
        options: Options(
          headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
        ));
    return 'ok';
  }

  Future<String> postRefuerzo(Map<String, dynamic> _body) async {
    final Response response = await _dio.post(Rest.SELLS_REFUERZO,
        data: _body,
        options: Options(
          headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
        ));
    return 'ok';
  }

  Future<String> sellVehicle(Map<String, dynamic> _body) async {
    final Response response = await _dio.post(Rest.SELLS,
        data: _body,
        options: Options(
          headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
        ));
    return 'ok';
  }

  Future<List<CuoteDetailModel>> requestCuotes(int? idVenta) async {
    final Response response =
        await _dio.get(Rest.SELLS_CUOTES_DETAILS + idVenta.toString(),
            options: Options(
              headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
            ));
    return (response.data['response'] as List)
        .map((e) => CuoteDetailModel.fromJson(e))
        .toList();
  }

  Future<List<RefuerzoDetailModel>> requestRefuerzos(int? idVenta) async {
    final Response response =
        await _dio.get(Rest.SELLS_REFUERZOS_DETAILS + idVenta.toString(),
            options: Options(
              headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
            ));
    return (response.data['response'] as List)
        .map((e) => RefuerzoDetailModel.fromJson(e))
        .toList();
  }

  Future<int> deleteVehicle(String idVehiculoSucursal) async {
    final Response response =
        await _dio.delete(Rest.VEHICLES + '/$idVehiculoSucursal',
            options: Options(
              headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
            ));
    return int.parse(idVehiculoSucursal);
  }

  Future<int> deleteVehiclePlan(int idPlan) async {
    final Response response = await _dio.delete(Rest.VEHICLES + '/plan/$idPlan',
        options: Options(
          headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
        ));
    return idPlan;
  }

  Future<int> updateDateSale(int idVenta, DateTime dateTime) async {
    print(_user.user?.value.token);
    print(Rest.SELLS + '/date');
    final Response response = await _dio.put(Rest.SELLS + '/date',
        data: {"id_venta": idVenta, "fecha_venta": dateTime.toString()},
        options: Options(
          headers: {'Authorization': 'Bearer: ${_user.user?.value.token}'},
        ));
    return idVenta;
  }
}
