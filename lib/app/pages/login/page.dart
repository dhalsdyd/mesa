import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:moji_backoffice/app/core/theme/color_theme.dart';
import 'package:moji_backoffice/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:moji_backoffice/app/pages/login/controller.dart';
import 'package:moji_backoffice/app/widgets/button.dart';
import 'package:moji_backoffice/app/widgets/footer.dart';
import 'package:moji_backoffice/app/widgets/header.dart';
import 'package:moji_backoffice/app/widgets/textfield.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({Key? key}) : super(key: key);

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

  LoginPageController get controller => Get.find<LoginPageController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(),
        const SizedBox(height: 50),
        const MAMSTextField(hintText: "Login ID"),
        const SizedBox(height: 20),
        const MAMSTextField(hintText: "Login PW", prefixIcon: Icons.lock),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                SvgPicture.asset("assets/svgs/exclaim.svg"),
                const SizedBox(width: 8),
                Text("Incorrect ID or PW", style: MAMSTextTheme.regular16.copyWith(color: const Color(0xffFF4646))),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        MAMSSmallTextButton(text: "Login", onTap: controller.login),
        const Expanded(child: SizedBox()),
        if (!web) const Footer()
      ],
    );
  }
}
