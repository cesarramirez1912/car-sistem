import 'package:car_system/colors.dart';
import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/deudor_controller.dart';
import 'package:car_system/route_manager.dart';
import 'package:car_system/widgets/search_input.dart';
import 'package:car_system/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeudorView extends StatelessWidget {
  DeudorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: controller.selectedIndex.value);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomSearchInput(
              hintText: 'Buscar por nombre',
              onChanged: (text) => controller.searchText(text),
              controller: controller.searchTextController,
              onClean: () => controller.searchText('')),
        ),
        title: const Text('Deudores'),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) => controller.selectedIndex.value = index,
          children: <Widget>[
            RefreshIndicator(
                onRefresh: () async => await controller.requestDeudores(),
                child: Cuotes()),
            RefreshIndicator(
                onRefresh: () async => await controller.requestDeudores(),
                child: Refuerzos()),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending_outlined),
              label:
                  'Cuotas ${controller.listDeudoresAgrupadoCuota.length.toString()}',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending_outlined),
              label:
                  'Refuerzos ${controller.listDeudoresAgrupadoRefuerzo.length.toString()}',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: ColorPalette.PRIMARY,
          onTap: (index) {
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut);
            controller.selectedIndex.value = index;
          },
        ),
      ),
    );
  }

  Widget Cuotes() {
    return Obx(
      () => ListView.builder(
        itemCount: controller.listDeudoresAgrupadoCuota.length,
        itemBuilder: (context, index) {
          return bodyDeudor(controller.listDeudoresAgrupadoCuota[index], true);
        },
      ),
    );
  }

  Widget Refuerzos() {
    return Obx(
      () => ListView.builder(
        itemCount: controller.listDeudoresAgrupadoRefuerzo.length,
        itemBuilder: (context, index) {
          return bodyDeudor(
              controller.listDeudoresAgrupadoRefuerzo[index], false);
        },
      ),
    );
  }

  Widget bodyDeudor(Map<String, dynamic> deudor, bool isCuote) {
    return Container(
      margin: const EdgeInsets.only(right: 5, left: 5, top: 2),
      child: Card(
        child: ListTile(
          onTap: () => Get.toNamed(RouterManager.DEUDOR_DETAIL_VIEW,
              parameters: {
                "idCliente": deudor['idCliente'].toString(),
                "isCuota": isCuote.toString()
              }),
          title: Text(deudor['cliente'].toString()),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              deudor['total_deuda_guaranies'] != 0 &&
                      deudor['total_deuda_guaranies'] != null
                  ? Text(
                      MoneyFormat()
                          .formatCommaToDot(
                              (deudor['total_deuda_guaranies'] ?? 0))
                          .toString(),
                      style: const TextStyle(color: Colors.red),
                    )
                  : Container(),
              deudor['total_deuda_dolares'] != 0 &&
                      deudor['total_deuda_dolares'] != null
                  ? Text(
                      MoneyFormat()
                          .formatCommaToDot(
                              (deudor['total_deuda_dolares'] ?? 0),
                              isGuaranies: false)
                          .toString(),
                      style: const TextStyle(color: Colors.red))
                  : Container(),
              conditionalRender(deudor['bajo'], 'Hasta 30 dias: '),
              conditionalRender(deudor['medio'], 'De 1 a 3 meses: '),
              conditionalRender(deudor['alto'], 'Más de 3 meses: '),
              CustomSpacing(height: 6),
            ],
          ),
          trailing: const Icon(Icons.chevron_right_sharp),
        ),
      ),
    );
  }

  Widget conditionalRender(dynamic total, String text) {
    return total != null
        ? Text(
            text + total.toString() + (total == 1 ? ' cuota' : ' cuotas'),
            style: const TextStyle(color: Colors.red),
          )
        : Container();
  }
}
