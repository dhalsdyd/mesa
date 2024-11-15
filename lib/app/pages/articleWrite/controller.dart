import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ArticleWritePageController extends GetxController with StateMixin {
  static ArticleWritePageController get to => Get.find<ArticleWritePageController>(); // add this line

  TextEditingController articleTitleController = TextEditingController();
  Rx<String> articleTitle = ''.obs;
  TextEditingController articleContentController = TextEditingController();
  Rx<String> articleContent = ''.obs;
  Rx<int> contentLength = 0.obs;

  TextEditingController moreInfoLinkController = TextEditingController();
  Rx<String> moreInfoLink = ''.obs;

  Rx<String> articleIamgeUrl = ''.obs;
  Rx<String> htmlView = ''.obs;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      articleIamgeUrl.value = pickedFile.path;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    articleTitleController.addListener(() {
      articleTitle.value = articleTitleController.text;
    });

    articleContentController.addListener(() {
      articleContent.value = articleContentController.text;
    });

    moreInfoLinkController.addListener(() {
      moreInfoLink.value = moreInfoLinkController.text;
    });

    ever(articleTitle, (_) {
      htmlView.value = "<h1>${articleTitle.value}</h1>";

      if (articleIamgeUrl.value != "") {
        htmlView.value = "<img src='${articleIamgeUrl.value}' style='height=300px'>";
      }
      htmlView.value += articleContent.value;
    });

    ever(articleIamgeUrl, (_) {
      htmlView.value += "<h1>${articleTitle.value}</h1>";
      htmlView.value = "<img src='${articleIamgeUrl.value}' style='height=300px'>";
      htmlView.value += articleContent.value;
    });

    ever(articleContent, (_) {
      htmlView.value = "<h1>${articleTitle.value}</h1>";
      if (articleIamgeUrl.value != "") {
        htmlView.value = "<img src='${articleIamgeUrl.value}' style='height=300px'>";
      }
      htmlView.value += articleContent.value;
      contentLength.value = articleContent.value.length;
    });
  }
}
