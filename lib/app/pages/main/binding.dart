import 'package:mesa/app/pages/home/controller.dart';
import 'package:mesa/app/pages/main/controller.dart';
import 'package:get/get.dart';
import 'package:mesa/app/pages/permission/controller.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(() => MainPageController());
    Get.lazyPut<PermissionPageController>(() => PermissionPageController());
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}
