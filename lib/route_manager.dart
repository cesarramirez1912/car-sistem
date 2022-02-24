import 'package:car_system/bindings/clients_binding.dart';
import 'package:car_system/bindings/list_vehicle_bindings.dart';
import 'package:car_system/bindings/login_binding.dart';
import 'package:car_system/bindings/register_vehicle_binding.dart';
import 'package:car_system/bindings/sell_from_collaborator_binding.dart';
import 'package:car_system/bindings/vehicle_detail_binding.dart';
import 'package:car_system/views/client_detail_view.dart';
import 'package:car_system/views/clients_view.dart';
import 'package:car_system/views/dash/dash_view.dart';
import 'package:car_system/views/dash/negocios/negocios_view.dart';
import 'package:car_system/views/dates_venc_cuotes_view.dart';
import 'package:car_system/views/deudor/deudor_detail_view.dart';
import 'package:car_system/views/deudor/deudor_view.dart';
import 'package:car_system/views/new_plan_view.dart';
import 'package:car_system/views/register_client_view.dart';
import 'package:car_system/views/list_vehicles_view.dart';
import 'package:car_system/views/login_view.dart';
import 'package:car_system/views/register_essencial_view.dart';
import 'package:car_system/views/register_vehicle_view.dart';
import 'package:car_system/views/sale_datail_view.dart';
import 'package:car_system/views/sell/dates_venc_view.dart';
import 'package:car_system/views/sell/sell_vehicle_view.dart';
import 'package:car_system/views/sells_from_collaborator_view.dart';
import 'package:car_system/views/vehicle_detail_view.dart';
import 'package:get/get.dart';

import 'bindings/dash_binding.dart';

class RouterManager {
  static const String LOGIN = '/login';
  static const String DASH = '/dash';
  static const String REGISTER_CLIENT = '/register_client';
  static const String VEHICLES = '/vehicles';
  static const String VEHICLE_DETAIL = '/vehicle_detail';
  static const String REGISTER= '/register_vehicle';
  static const String REGISTER_ESSENCIAL = '/register_essencial_information';
  static const String SEL_VEHICLE= '/sel_vehicle';
  static const String DATES_VEN= '/dates_venc';
  static const String SELLS_FROM_COLLABORATOR= '/sells_from_collaborator';
  static const String SELLS_DETAILS_CUOTES= '/sells_details_cuotes';
  static const String NEW_PLAN_VIEW= '/new_plan_view';
  static const String CLIENT_DETAIL_VIEW= '/client_detail_view';
  static const String SALE_DETAIL_VIEW= '/sale_detail_view';
  static const String CLIENTS_VIEW= '/clients_view';
  static const String DEUDOR_VIEW= '/deudor_view';
  static const String DEUDOR_DETAIL_VIEW= '/deudor_detail_view';
  static const String NEGOCIOS_VIEW= '/negocios_view';

  static List<GetPage> getRoutes() => [
    GetPage(name: LOGIN, page: () => LoginView(),binding: LoginBindings()),
    GetPage(name: DASH, page: () => DashView(), binding: DashBindings()),
    GetPage(name: REGISTER_CLIENT, page: () => RegisterClientView()),
    GetPage(name: VEHICLES, page: () => ListVehiclesView(),binding: ListVehicleBindings()),
    GetPage(name: VEHICLE_DETAIL, page: () => VehicleDetailView(),binding: VehicleDetailBinding()),
    GetPage(name: REGISTER, page: () => RegisterVehicleView(), binding: RegisterVehicleBinding()),
    GetPage(name: SEL_VEHICLE, page: () => SellVehicleView(), binding: SellFromCollaboratorBinding()),
    GetPage(name: DATES_VEN, page: () => DatesVencView()),
    GetPage(name: SELLS_FROM_COLLABORATOR, page: () => SellsFromCollaboratorView(),binding:SellFromCollaboratorBinding()),
    GetPage(name: SELLS_DETAILS_CUOTES, page: () => DatesVencCuotesView(),),
    GetPage(name: REGISTER_ESSENCIAL, page: () => RegisterEssencialView(),),
    GetPage(name: NEW_PLAN_VIEW, page: () => NewPlanView(),),
    GetPage(name: CLIENT_DETAIL_VIEW, page: () => ClientDetailView(),),
    GetPage(name: SALE_DETAIL_VIEW, page: () => SaleDetailView(),),
    GetPage(name: CLIENTS_VIEW, page: () => ClientsView(),binding: ClientBinding()),
    GetPage(name: DEUDOR_VIEW, page: () => DeudorView(),),
    GetPage(name: DEUDOR_DETAIL_VIEW, page: () => DeudorDetailView(),),
    GetPage(name: NEGOCIOS_VIEW, page: () => NegociosView() ),
  ];
}