import 'package:moji_backoffice/app/core/theme/color_theme.dart';
import 'package:moji_backoffice/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:moji_backoffice/app/widgets/button.dart';
import 'package:moji_backoffice/app/widgets/footer.dart';
import 'package:moji_backoffice/app/widgets/header.dart';

class ArticleViewPage extends StatelessWidget {
  const ArticleViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MAMSColors.background,
      body: SafeArea(
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
                const Text("아티클 미리보기", style: MAMSTextTheme.medium16),
                const SizedBox(height: 8),
                // TODO : HTML VIEWER
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    color: MAMSColors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: MAMSColors.border, width: 1),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Text("아티클 미리보기", style: MAMSTextTheme.medium16),
                ),

                const SizedBox(height: 30),
                const MAMSSmallTextButton(text: "최종 마감"),
                const SizedBox(height: 20),
                const MAMSSmallTextButton(
                  text: "수정하기",
                  color: MAMSColors.button2,
                ),
                const SizedBox(height: 40),
                const Footer(),
              ],
            )),
          ))
        ],
      )),
    );
  }
}
