import 'package:car_system/app/modules/login/login_view.dart';
import 'package:car_system/app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../modules/client/client_detail/client_detail_view.dart';
import '../modules/client/clients_binding.dart';
import '../modules/client/clients_view.dart';
import '../modules/client/register_client/register_client_view.dart';
import '../modules/cuote_month/cuote_month_detail_view.dart';
import '../modules/cuote_month/cuotes_month_binding.dart';
import '../modules/cuote_month/principal_cuotes_month.dart';
import '../modules/dash/dash_binding.dart';
import '../modules/dash/dash_view.dart';
import '../modules/dates_venc_cuotes/dates_venc_cuotes_view.dart';
import '../modules/deudor/deudor_detail_view.dart';
import '../modules/deudor/deudor_view.dart';
import '../modules/essencial/register_essencial_view.dart';
import '../modules/list_vehicles/list_vehicle_bindings.dart';
import '../modules/list_vehicles/list_vehicles_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/negocios/negocios_view.dart';
import '../modules/plan/new_plan_view.dart';
import '../modules/register_vehicle/register_vehicle_binding.dart';
import '../modules/register_vehicle/register_vehicle_view.dart';
import '../modules/sale_detail/sale_datail_view.dart';
import '../modules/sells/dates_venc_view.dart';
import '../modules/sells/sell_from_collaborator_binding.dart';
import '../modules/sells/sell_vehicle_view.dart';
import '../modules/sells/sells_from_collaborator_view.dart';
import '../modules/vehicle_detail/vehicle_detail_bindings.dart';
import '../modules/vehicle_detail/vehicle_detail_view.dart';


class AppPages{
  static final  List<GetPage> pages = [
    GetPage(name: AppRoutes.LOGIN, page: () => LoginView(),binding: LoginBindings()),
    GetPage(name: AppRoutes.DASH, page: () => DashView(), binding: DashBindings()),
    GetPage(name: AppRoutes.REGISTER_CLIENT, page: () => RegisterClientView()),
    GetPage(name: AppRoutes.VEHICLES, page: () => ListVehiclesView(),binding: ListVehicleBindings()),
    GetPage(name: AppRoutes.VEHICLE_DETAIL, page: () => VehicleDetailView(),binding: VehicleDetailBinding()),
    GetPage(name: AppRoutes.REGISTER, page: () => RegisterVehicleView(), binding: RegisterVehicleBinding()),
    GetPage(name: AppRoutes.SEL_VEHICLE, page: () => SellVehicleView(), binding: SellFromCollaboratorBinding()),
    GetPage(name: AppRoutes.DATES_VEN, page: () => DatesVencView()),
    GetPage(name: AppRoutes.SELLS_FROM_COLLABORATOR, page: () => SellsFromCollaboratorView(),binding:SellFromCollaboratorBinding()),
    GetPage(name: AppRoutes.SELLS_DETAILS_CUOTES, page: () => DatesVencCuotesView(),),
    GetPage(name: AppRoutes.REGISTER_ESSENCIAL, page: () => RegisterEssencialView(),),
    GetPage(name: AppRoutes.NEW_PLAN_VIEW, page: () => NewPlanView(),),
    GetPage(name: AppRoutes.CLIENT_DETAIL_VIEW, page: () => ClientDetailView(),),
    GetPage(name: AppRoutes.SALE_DETAIL_VIEW, page: () => SaleDetailView(),),
    GetPage(name: AppRoutes.CLIENTS_VIEW, page: () => ClientsView(),binding: ClientBinding()),
    GetPage(name: AppRoutes.DEUDOR_VIEW, page: () => DeudorView(),),
    GetPage(name: AppRoutes.CUOTES_MONTH, page: () => PrincipalCuotesMonth(),binding: CuotesMonthBinding()),
    GetPage(name: AppRoutes.DEUDOR_DETAIL_VIEW, page: () => DeudorDetailView(),),
    GetPage(name: AppRoutes.CUOTE_MONTH_DETAIL_VIEW, page: () => CuoteMonthDetailView(),),
     GetPage(name: AppRoutes.NEGOCIOS_VIEW, page: () => NegociosView() ),
  ];
}