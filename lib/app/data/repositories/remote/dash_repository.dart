import 'package:car_system/app/data/providers/remote/dash_api.dart';
import 'package:get/get.dart';

class DashRepository {
  final DashApi _dashApi = Get.find<DashApi>();

  Future<List<Total>> requestCobrosMes(int? idEmpresa, int month, int year) =>
      _dashApi.requestCobrosMes(idEmpresa, month, year);

  Future<List<TotalVenta>> requestTotalVentasMes(int? idEmpresa, int month,
      int year) => _dashApi.requestTotalVentasMes(idEmpresa, month, year);

  Future<List<Count>> requestCount(int? idEmpresa, int month, int year) =>
      _dashApi.requestCount(idEmpresa, month, year);

  Future<dynamic> requestCountCuotesPagos(int? idEmpresa, int? month,
      int year) => _dashApi.requestCountCuotesPagos(idEmpresa, month, year);

  Future<dynamic> requestNegocios(int? idEmpresa, int? month, int year) =>
      _dashApi.requestNegocios(idEmpresa, month, year);
}