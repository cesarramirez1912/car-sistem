import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/rest.dart';
import 'package:get/get.dart';

class SellVehicleRepository extends GetConnect {
  Future<dynamic> sellVehicle(Map<String, dynamic> _body) async {
    final response = await post(Rest.SELLS, _body);
    if (response.status.hasError) {
      if (response.body['message'] != '') {
        return Future.error(response.body['message']);
      } else {
        return Future.error(
            'Ocurrió un error al hacer venta, intente de nuevo.');
      }
    } else {
      return 'ok';
    }
  }
}
