import 'package:flutter/cupertino.dart';
import 'package:moji_backoffice/app/core/theme/color_theme.dart';
import 'package:moji_backoffice/app/data/initalize.dart';
import 'package:moji_backoffice/app/routes/pages.dart';
import 'package:moji_backoffice/app/routes/route.dart';
import 'package:moji_backoffice/app/translation/translation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

void main() async {
  //WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  // Do Firebase Initial Settings With Firebase CLI
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppInitalizer().init();
  //Get.config();
  runApp(
    GetMaterialApp(
      //unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
      initialRoute: Routes.login,
      getPages: AppPages.pages,
      theme: ThemeData(
          fontFamily: "Pretendard",
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: MAMSColors.description,
            selectionHandleColor: MAMSColors.mainBlack,
            cursorColor: MAMSColors.mainBlack,
          ),
          cupertinoOverrideTheme: const CupertinoThemeData(primaryColor: MAMSColors.mainBlack)),
      locale: GetCurrentLocale.currentDeviceLocale,
      fallbackLocale: GetCurrentLocale.fallBackLocale,
      //routingCallback
      //GetObserver
    ),
  );
}
