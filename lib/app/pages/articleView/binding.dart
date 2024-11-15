import 'package:moji_backoffice/app/pages/articleView/controller.dart';
import 'package:get/get.dart';

class ArticleViewPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleViewPageController>(() => ArticleViewPageController());
  }
}
