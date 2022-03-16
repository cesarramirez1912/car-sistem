import 'package:car_system/app/data/models/cuote_detail_model.dart';
import 'package:car_system/app/data/models/refuerzo_detail_model.dart';
import 'package:car_system/app/data/models/sale_collaborator_model.dart';
import 'package:car_system/app/data/providers/remote/clients_api.dart';
import 'package:car_system/app/data/providers/remote/sells_api.dart';
import 'package:get/get.dart';

import '../../models/register_client_model.dart';

class ClientsRepository{
  final ClientsApi _clientsApi = Get.find<ClientsApi>();

  Future<List<ClientModel>> requestClients(int? idCompany) =>_clientsApi.requestClients(idCompany);

  Future<int> createClient(Map<String, dynamic> _body) =>_clientsApi.createClient(_body);
}