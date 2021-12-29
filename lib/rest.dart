class Rest {
  static const String BASE_URL_TEST = "http://192.168.251.209:3000";
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
  static String VEHICLES_BRANCH = BASE_URL+VEHICLES + "/branch=";
}
