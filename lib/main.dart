import 'package:flutter/cupertino.dart';
import 'package:mesa/app/core/theme/color_theme.dart';
import 'package:mesa/app/data/initalize.dart';
import 'package:mesa/app/routes/pages.dart';
import 'package:mesa/app/routes/route.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

void main() async {
  //WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitalizer().init();
  //Get.config();
  runApp(
    GetMaterialApp(
      //unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
      title: "MESA",
      initialRoute: Routes.login,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Pretendard",
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: MESAColors.description,
            selectionHandleColor: MESAColors.mainBlack,
            cursorColor: MESAColors.mainBlack,
          ),
          cupertinoOverrideTheme: const CupertinoThemeData(primaryColor: MESAColors.mainBlack)),

      //routingCallback
      //GetObserver
    ),
  );
}
