import 'package:car_system/controllers/client_detail_controller.dart';
import 'package:car_system/responsive.dart';
import 'package:car_system/widgets/client_body.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:car_system/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientDetailView extends StatelessWidget {
  ClientDetailController controller = Get.put(ClientDetailController());

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
        title: const Text('Detalles del cliente'),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomSpacing(),
                            CustomTitle('Cliente'),
                            CustomSpacing(),
                            const Divider(
                              height: 2,
                              color: Colors.grey,
                            ),
                            CustomSpacing(),
                            ClientBody(controller.client.value)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
