import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/register_client_model.dart';
import '../../global_widgets/responsive.dart';
import '../../global_widgets/search_input.dart';
import '../../routes/app_routes.dart';
import 'client_controller.dart';

class ClientsView extends GetView<ClientController> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: principal(context),
        tablet: Center(
          child: Container(
              alignment: Alignment.center,
              width: 900,
              child: principal(context)),
        ),
        desktop: Center(
          child: Container(
              alignment: Alignment.center,
              width: 900,
              child: principal(context)),
        ));
  }

  Widget principal(context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Responsive.isTablet(context) || Responsive.isDesktop(context)
              ? IconButton(
                  onPressed: () async {
                    controller.isLoading.value = true;
                    await controller.requestClients();
                    controller.isLoading.value = false;
                  },
                  icon: const Icon(Icons.refresh))
              : Container(),
        ],
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
      body: RefreshIndicator(
        onRefresh: () => controller.requestClients(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: controller.listClients.length,
                    itemBuilder: (BuildContext context, int index) {
                      ClientModel _client = controller.listClients[index];
                      return Card(
                        child: ListTile(
                          onTap: () => Get.toNamed(
                              AppRoutes.CLIENT_DETAIL_VIEW,
                              parameters: _client.toJson().map((key, value) =>
                                  MapEntry(key, value.toString()))),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _client.cliente ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                _client.celular ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w200, fontSize: 13),
                              ),
                              const SizedBox(height: 5)
                            ],
                          ),
                          subtitle: Text(_client.ciudad ?? ''),
                          trailing: const Icon(Icons.chevron_right_sharp),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
