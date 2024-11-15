import 'package:moji_backoffice/app/pages/articleWrite/controller.dart';
import 'package:get/get.dart';

class ArticleWritePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleWritePageController>(() => ArticleWritePageController());
  }
}
