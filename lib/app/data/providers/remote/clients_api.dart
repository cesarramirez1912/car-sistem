import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../../../../rest.dart';
import '../../models/register_client_model.dart';

class ClientsApi{
  final Dio _dio = Get.find<Dio>();

  Future<List<ClientModel>> requestClients(int? idCompany) async {
    final Response response =
    await _dio.get(Rest.CLIENTS_FROM_COMPANY + idCompany.toString());
    return (response.data['response'] as List).map((e) => ClientModel.fromJson(e)).toList();
  }

  Future<int> createClient(Map<String, dynamic> _body) async {
    final Response response = await _dio.post(Rest.CLIENTS, data:_body);
    return response.data['response'][0]['id_cliente'];
  }
}