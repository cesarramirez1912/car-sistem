import 'package:car_system/controllers/client_controller.dart';
import 'package:car_system/models/register_client_model.dart';
import 'package:car_system/widgets/client_body.dart';
import 'package:car_system/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientsView extends StatelessWidget {
  ClientController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomSearchInput(
            hintText: 'Buscar por nombre',
            controller: TextEditingController(),
            onClean: () =>
                controller.listClients.value = controller.listClientsAux.value,
            onChanged: (text) {
              controller.listClients.value = controller.listClientsAux.value
                  .where((p0) => p0.cliente!.contains(text.toUpperCase()))
                  .toList();
            },
          ),
        ),
        title: const Text('Clientes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.listClients.length,
            itemBuilder: (BuildContext context, int index) {
              ClientModel _client = controller.listClients[index];
              return Card(
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(_client.cliente.toString()),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16, left: 16, right: 16),
                          child: ClientBody(_client),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
