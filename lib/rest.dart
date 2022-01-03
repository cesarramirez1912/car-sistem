class Rest {
  //static const String BASE_URL_TEST = "http://192.168.0.2:3000";
  static const String BASE_URL_TEST = "http://192.168.88.112:3000";
  static const String VEHICLES = '/vehicles';
  static const String BASE_URL_PRODUCTION =
      "https://matrisoja-crm.herokuapp.com";

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
  static String CLIENTS = BASE_URL + "/clients";
  static String MOTORS = BASE_URL + "/motors";
  static String BRANDS = BASE_URL + "/brands";
  static String FUELS = BASE_URL + "/fuels";
  static String MODELS = BASE_URL + "/models";
  static String COLORS = BASE_URL + "/colors";
  static String VEHICLES_BRANCH = BASE_URL + VEHICLES + "/branch=";
}
