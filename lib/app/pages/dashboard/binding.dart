import 'package:mesa/app/pages/dashboard/controller.dart';
import 'package:get/get.dart';

class DashboardPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardPageController>(() => DashboardPageController());
  }
}
