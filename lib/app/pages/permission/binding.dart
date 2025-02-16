import 'package:mesa/app/pages/permission/controller.dart';
import 'package:get/get.dart';

class PermissionPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PermissionPageController>(() => PermissionPageController());
  }
}
