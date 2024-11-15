import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moji_backoffice/app/core/theme/color_theme.dart';
import 'package:moji_backoffice/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:moji_backoffice/app/pages/articleWrite/controller.dart';
import 'package:moji_backoffice/app/widgets/button.dart';
import 'package:moji_backoffice/app/widgets/footer.dart';
import 'package:moji_backoffice/app/widgets/header.dart';
import 'package:moji_backoffice/app/widgets/textfield.dart';

class ArticleWritePage extends GetView<ArticleWritePageController> {
  const ArticleWritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MAMSColors.background,
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 70),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Header(),
                      const SizedBox(height: 50),
                      DefaultView(),
                    ],
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: MAMSColors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("김아인님, 반갑습니다.", style: MAMSTextTheme.medium16),
                        const Text("아티클 작성 시스템", style: MAMSTextTheme.semiBold22),
                        const SizedBox(height: 50),
                        const Text("아티클 미리보기", style: MAMSTextTheme.medium16),
                        const SizedBox(height: 8),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: MAMSColors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: MAMSColors.border, width: 1),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Obx(
                              () => HtmlWidget(
                                controller.htmlView.value,
                                textStyle: MAMSTextTheme.medium16,
                                customWidgetBuilder: (element) {},
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ArticleHeader(),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("김아인님, 반갑습니다.", style: MAMSTextTheme.medium16),
                        const Text("아티클 작성 시스템", style: MAMSTextTheme.semiBold22),
                        const SizedBox(height: 30),
                        DefaultView()
                      ],
                    ),
                  )),
            ),
          ],
        ));
      }),
    );
  }
}

class DefaultView extends StatelessWidget {
  const DefaultView({
    super.key,
  });

  ArticleWritePageController get controller => Get.find<ArticleWritePageController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("작성된 주제", style: MAMSTextTheme.medium16),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: MAMSColors.button,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: MAMSColors.border, width: 1),
          ),
          padding: const EdgeInsets.all(12),
          child: Text("아직 작성된 주제가 없어요.", style: MAMSTextTheme.medium16.copyWith(color: MAMSColors.description)),
        ),
        const SizedBox(height: 30),
        const Text("아티클 제목", style: MAMSTextTheme.medium16),
        const SizedBox(height: 8),
        MAMSTextField2(hintText: "아티클 제목을 작성해주세요.", controller: controller.articleTitleController),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("아티클 본문", style: MAMSTextTheme.medium16),
            Obx(() => Text("${controller.contentLength}자", style: MAMSTextTheme.medium16)),
          ],
        ),
        const SizedBox(height: 8),
        MAMSTextField2(
          hintText: "아티클 본문을 작성해주세요.",
          controller: controller.articleContentController,
          maxLine: null,
        ),
        const SizedBox(height: 30),
        const Text("(선택) 더 알아보기 버튼 링크", style: MAMSTextTheme.medium16),
        const SizedBox(height: 8),
        MAMSTextField2(hintText: "(선택) 더 알아보기 버튼 링크를 넣어주세요.", controller: controller.moreInfoLinkController),
        const SizedBox(height: 30),
        const Text("아티클 사진", style: MAMSTextTheme.medium16),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            controller.pickImage();
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: MAMSColors.button,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: MAMSColors.border, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Obx(() => Text("${controller.articleIamgeUrl.isNotEmpty ? controller.articleIamgeUrl : "아티클 사진 선택"}",
                  style: MAMSTextTheme.medium16.copyWith(color: MAMSColors.description))),
            ),
          ),
        ),
        const SizedBox(height: 30),
        const MAMSSmallTextButton(text: "최종 마감"),
        const SizedBox(height: 40),
        const Footer(),
      ],
    );
  }
}
