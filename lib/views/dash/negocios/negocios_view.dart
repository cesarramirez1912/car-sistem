import 'package:car_system/common/date_format.dart';
import 'package:car_system/controllers/negocios_controller.dart';
import 'package:car_system/responsive.dart';
import 'package:car_system/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/models/sale_collaborator_model.dart';
import '../../../colors.dart';

class NegociosView extends StatelessWidget {
  NegociosController controller = Get.put(NegociosController());

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: principal(context),
      tablet: Center(
        child: Container(
            alignment: Alignment.center, width: 900, child: principal(context)),
      ),
      desktop: Center(
        child: Container(
            alignment: Alignment.center, width: 900, child: principal(context)),
      ),
    );
  }

  Widget principal(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VENTAS'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: IconButton(
                      onPressed: () async {
                        controller.isLoading.value = true;
                        controller.firstDateCuoteSelected.value = DateTime.utc(
                            controller.firstDateCuoteSelected.value.year,
                            controller.firstDateCuoteSelected.value.month - 1,
                            1);
                        await controller.requestNegocios();
                        controller.isLoading.value = false;
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                        color: ColorPalette.GRAY_TITLE,
                      ))),
              Expanded(
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        DateFormatBr().formatBrMonthNamed(
                          controller.firstDateCuoteSelected.value.toString(),
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        controller.firstDateCuoteSelected.value.year.toString(),
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                  child: IconButton(
                      onPressed: () async {
                        controller.isLoading.value = true;
                        controller.firstDateCuoteSelected.value = DateTime.utc(
                            controller.firstDateCuoteSelected.value.year,
                            controller.firstDateCuoteSelected.value.month + 1,
                            1);

                        await controller.requestNegocios();
                        controller.isLoading.value = false;
                      },
                      icon: const Icon(
                        Icons.chevron_right,
                        color: ColorPalette.GRAY_TITLE,
                      )))
            ],
          ),
        ),
        actions: [
          Responsive.isTablet(context) || Responsive.isDesktop(context)
              ? IconButton(
                  onPressed: () async {
                    controller.isLoading.value = true;
                    await controller.requestNegocios();
                    controller.isLoading.value = false;
                  },
                  icon: const Icon(Icons.refresh))
              : Container(),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.listSales.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.listSales.length,
                    itemBuilder: (context, index) {
                      SaleCollaboratorModel saleCollaborator =
                          controller.listSales[index];
                      return Card(
                        child: ListTile(
                          onTap: () => Get.toNamed(
                              RouterManager.SALE_DETAIL_VIEW,
                              parameters: saleCollaborator.toJson().map(
                                  (key, value) =>
                                      MapEntry(key, value.toString()))),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                saleCollaborator.marca ?? '',
                                style: const TextStyle(
                                    color: ColorPalette.BLACK_TITLE,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                saleCollaborator.cliente ?? '',
                                style: const TextStyle(
                                    color: ColorPalette.BLACK_TITLE,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                (saleCollaborator.contadoGuaranies != null ||
                                            saleCollaborator.contadoDolares !=
                                                null
                                        ? 'CONTADO - '
                                        : 'FINANCIADO - ') +
                                    (saleCollaborator.chapa ?? 'SIN CHAPA'),
                                style: const TextStyle(
                                    color: ColorPalette.BLACK_TITLE,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                          subtitle: Text(DateFormatBr().formatBrFromString(
                              saleCollaborator.fechaVenta ?? '')),
                          trailing: const Icon(Icons.chevron_right_sharp),
                        ),
                      );
                    })
                : const Center(
                    child: Text('Sin ventas en el mes'),
                  ),
      ),
    );
  }
}
