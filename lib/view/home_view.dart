import 'package:car_system/common/money_format.dart';
import 'package:car_system/controllers/home_controller.dart';
import 'package:car_system/models/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(
          title: Text('Vehiculos'),
        ),
        body: Obx(
          () => RefreshIndicator(
            onRefresh: () async => await controller.fetchVehicles(),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: controller.vehicles.length,
                itemBuilder: (BuildContext context, int index) {
                  Vehicle _vehicle = controller.vehicles[index];
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.image,
                          size: 150,
                          color: Color.fromRGBO(160, 160, 160, 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(_vehicle.marca,
                                      style: const TextStyle(
                                          color: Color.fromRGBO(72, 72, 72, 1))),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    _vehicle.modelo,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(72, 72, 72, 1)),
                                  ),
                                ],
                              ),
                              Text(
                                _vehicle.motor,
                                style: const TextStyle(
                                    color: Color.fromRGBO(72, 72, 72, 1)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "G\$ ${MoneyFormat().formatCommaToDot(_vehicle.contadoGuaranies.toString())}",
                                style: const TextStyle(
                                    color: Color.fromRGBO(72, 72, 72, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                _vehicle.ano,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
}
