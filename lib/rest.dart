class Rest {
  //static const String BASE_URL_TEST = "http://192.168.0.2:5480";
  //static const String BASE_URL_TEST = "http://172.20.10.5:5480";
  static const String BASE_URL_TEST = "http://192.168.88.112:5480";
  static const String BASE_URL_PRODUCTION =
      "https://carsystembackend.herokuapp.com";

  static String get BASE_URL {
    return BASE_URL_TEST;
    /*  if(kReleaseMode){
      return RestRoutes.BASE_URL_PRODUCTION;
    } else {
      return RestRoutes.BASE_URL_TEST;
    }*/
  }

  // api routes
  static String LOGIN = BASE_URL + "/login";
  static String USER_INFORMATION = BASE_URL + "/user=";
  static String CLIENTS = BASE_URL + "/clients";
  static String CLIENTS_FROM_COMPANY = CLIENTS + "/company=";
  static String MOTORS = BASE_URL + "/motors";
  static String GEARS = BASE_URL + "/gears";
  static String BRANDS = BASE_URL + "/brands";
  static String CATEGORIES = BASE_URL + "/categories";
  static String FUELS = BASE_URL + "/fuels";
  static String VEHICLES = BASE_URL + '/vehicles';
  static String MODELS = BASE_URL + "/models";
  static String COLORS = BASE_URL + "/colors";
  static String VEHICLES_BRANCH = VEHICLES + "/branch=";
  static String SELLS = BASE_URL + "/sells";
  static String SELLS_CUOTE = SELLS + "/cuote";
  static String SELLS_REFUERZO = SELLS + "/refuerzo";
  static String SELLS_COLLABORATOR = SELLS + "/collaborator=";
  static String SELLS_CUOTES_DETAILS = SELLS + "/detail/cuote/idVenta=";
  static String SELLS_REFUERZOS_DETAILS = SELLS + "/detail/refuerzo/idVenta=";
  static String DEUDORES_CUOTA = BASE_URL + "/debtor/cuota/company=";
  static String DEUDORES_REFUERZO = BASE_URL + "/debtor/refuerzo/company=";
  static String COBROS_MES = SELLS + "/cobros/idEmpresa=";
  static String VENTAS_MES = SELLS + "/idEmpresa=";
  static String COUNT_VENTA_MES = SELLS + "/count/idEmpresa=";
  static String COUNT_CUOTES_PAGOS_MES = SELLS + "/countCuotes/idEmpresa=";
  static String NEGOCIOS_MES = SELLS + "/negocios/idEmpresa=";
}
