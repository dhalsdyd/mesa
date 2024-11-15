import 'package:get/get.dart';
import 'package:moji_backoffice/app/core/theme/color_theme.dart';
import 'package:moji_backoffice/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:moji_backoffice/app/pages/main/controller.dart';
import 'package:moji_backoffice/app/pages/main/widget/mams_card.dart';
import 'package:moji_backoffice/app/widgets/footer.dart';
import 'package:moji_backoffice/app/widgets/header.dart';

class MainPage extends GetView<MainPageController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MAMSColors.background,
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 70),
                    child: Column(
                      children: [
                        Header(),
                        Expanded(child: SizedBox()),
                        Footer(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: 522,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 70),
                    child: DefaultView(web: true),
                  ))),
            ],
          );
        }
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(40),
          child: DefaultView(),
        ));
      }),
    );
  }
}

class DefaultView extends StatelessWidget {
  const DefaultView({
    super.key,
    this.web = false,
  });

  final bool web;

  MainPageController get controller => MainPageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(),
        const SizedBox(height: 50),
        const Text("김아인님, 반갑습니다!", style: MAMSTextTheme.semiBold20),
        const SizedBox(height: 20),
        MAMSCard(svgPath: "write.svg", title: "아티클 작성 시스템", onTap: () => controller.goToArticleWrite()),
        const SizedBox(height: 20),
        MAMSCard(svgPath: "checklist.svg", title: "아티클 관리 시스템"),
        const Expanded(child: SizedBox()),
        if (!web) const Footer(),
      ],
    );
  }
}
