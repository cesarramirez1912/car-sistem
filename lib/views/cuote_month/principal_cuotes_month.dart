import 'package:car_system/colors.dart';
import 'package:car_system/widgets/shared_components/list_card_cuotes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/modules/cuote_month/cuotes_month_controller.dart';
import '../../common/date_format.dart';
import '../../responsive.dart';
import '../../widgets/search_input.dart';

class PrincipalCuotesMonth extends StatelessWidget {
  CuotesMonthController controller = Get.find();

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
                    await controller.requestDeudoresMonth();
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
        title: const Text('Cuotas por mes'),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            changeMonth(),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) =>
                    controller.selectedIndex.value = index,
                children: <Widget>[
                  RefreshIndicator(
                      onRefresh: () async =>
                          await controller.requestDeudoresMonth(),
                      child: Cuotes()),
                  RefreshIndicator(
                      onRefresh: () async =>
                          await controller.requestDeudoresMonth(),
                      child: Refuerzos()),
                ],
              ),
            )
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

  Widget changeMonth() {
    return Container(
      color: Colors.white,
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
                    await controller.requestDeudoresMonth();
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

                    await controller.requestDeudoresMonth();
                    controller.isLoading.value = false;
                  },
                  icon: const Icon(
                    Icons.chevron_right,
                    color: ColorPalette.GRAY_TITLE,
                  )))
        ],
      ),
    );
  }

  Widget Cuotes() {
    return Obx(() => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : listCardCuotes(controller.listDeudoresAgrupadoCuota, true,
            isDeudor: false, withDaysOrMonth: false));
  }

  Widget Refuerzos() {
    return Obx(() => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : listCardCuotes(controller.listDeudoresAgrupadoRefuerzo, false,
            isDeudor: false, withDaysOrMonth: false));
  }
}
