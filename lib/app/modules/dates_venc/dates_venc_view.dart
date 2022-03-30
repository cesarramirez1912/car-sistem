import 'package:car_system/app/modules/dates_venc/dates_venc_widgets/dates_venc_cuotes.dart';
import 'package:car_system/app/modules/dates_venc/dates_venc_widgets/dates_venc_refuerzos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colors.dart';
import 'dates_venc_controller.dart';

class DatesVencView extends StatelessWidget {
  DatesVencController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: controller.selectedIndex.value);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fechas generadas'),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) => controller.selectedIndex.value = index,
          children: <Widget>[
            DateVencCuotes(context),
            DateVencRefuerzos(context),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending_outlined),
              label:
                  'Cuotas ${controller.listDateGeneratedCuotas.length.toString()}',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending_outlined),
              label:
                  'Refuerzos ${controller.listDateGeneratedRefuerzos.length.toString()}',
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
}
