import 'package:get/get.dart';
import 'package:moji_backoffice/app/routes/route.dart';

class MainPageController extends GetxController with StateMixin {
  static MainPageController get to => Get.find<MainPageController>(); // add this line

  void goToArticleWrite() {
    Get.toNamed(Routes.articleWrite);
  }
}
