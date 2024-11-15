import 'package:get/get.dart';
import 'package:moji_backoffice/app/routes/route.dart';

class LoginPageController extends GetxController with StateMixin {
  static LoginPageController get to => Get.find<LoginPageController>(); // add this line

  Future<void> login() async {
    Get.toNamed(Routes.main);
  }
}
