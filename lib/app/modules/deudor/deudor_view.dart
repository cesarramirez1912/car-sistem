import 'package:car_system/app/global_widgets/search_input.dart';
import 'package:car_system/app/global_widgets/shared_components/list_card_cuotes.dart';
import '../../core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/responsive.dart';
import 'deudor_controller.dart';


class DeudorView extends StatelessWidget {
  DeudorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: controller.selectedIndex.value);
    return Responsive(
      mobile: principal(context, pageController),
      desktop: Center(
        child: Container(
            alignment: Alignment.center,
            width: 900,
            child: principal(context, pageController)),
      ),
      tablet: Center(
        child: Container(
            alignment: Alignment.center,
            width: 900,
            child: principal(context, pageController)),
      ),
    );
  }

  Widget principal(context, pageController) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Responsive.isTablet(context) || Responsive.isDesktop(context)
              ? IconButton(
                  onPressed: () async {
                    controller.isLoading.value = true;
                    await controller.requestDeudores();
                    controller.isLoading.value = false;
                  },
                  icon: const Icon(Icons.refresh))
              : Container(),
        ],
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
    return Obx(() => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : listCardCuotes(controller.listDeudoresAgrupadoCuota, true,
            withDate: false));
  }

  Widget Refuerzos() {
    return Obx(() => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : listCardCuotes(controller.listDeudoresAgrupadoRefuerzo, true,
            withDate: false));
  }
}
