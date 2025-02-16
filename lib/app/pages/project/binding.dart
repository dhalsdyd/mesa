import 'package:mesa/app/pages/project/controller.dart';
import 'package:get/get.dart';

class ProjectPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectPageController>(() => ProjectPageController());
  }
}
