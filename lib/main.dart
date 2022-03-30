import 'package:car_system/app/core/utils/dependency_injection.dart';
import 'package:car_system/app/modules/splash/splash_binding.dart';
import 'package:car_system/app/modules/splash/splash_page.dart';
import 'package:car_system/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/core/theme/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(
    GetMaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.keepFactory,
      home: SplashPage(),
      initialBinding: SplashBinding(),
      getPages: AppPages.pages,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: ColorPalette.PRIMARY, //change your color here
              ),
              titleTextStyle: TextStyle(
                  color: ColorPalette.PRIMARY,
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
              backgroundColor: Colors.white,
              elevation: 0),
          fontFamily: 'Poppins',
          primaryColor: ColorPalette.PRIMARY),
    ),
  );
}
