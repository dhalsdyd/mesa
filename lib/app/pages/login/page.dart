import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mesa/app/core/theme/color_theme.dart';
import 'package:mesa/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:mesa/app/pages/login/controller.dart';
import 'package:mesa/app/widgets/button.dart';
import 'package:mesa/app/widgets/header.dart';
import 'package:mesa/app/widgets/textfield.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MESAColors.background,
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const AssetImage("assets/images/background.png"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.white.withValues(alpha: 0.8), BlendMode.srcOver)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  width: 600,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 70),
                    child: DefaultView(web: true),
                  ))),
            ],
          );
        }

        return const SafeArea(
            child: Padding(
          padding: EdgeInsets.all(40),
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
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Obx(() {
            if (controller.isRegister.value) {
              return _signUp();
            } else {
              return _login();
            }
          }),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  Column _signUp() {
    return Column(
      children: [
        MESATextField(hintText: "Full Name", prefixIcon: Icons.badge, controller: controller.fullNameController),
        const SizedBox(height: 20),
        MESATextField(hintText: "Email", prefixIcon: Icons.mail, controller: controller.emailController),
        const SizedBox(height: 20),
        MESATextField(hintText: "User Name", prefixIcon: Icons.person, controller: controller.userNameController),
        const SizedBox(height: 20),
        MESATextField(hintText: "Company Name", prefixIcon: Icons.domain, controller: controller.companyNameController),
        const SizedBox(height: 20),
        MESATextField(hintText: "Password", prefixIcon: Icons.key, isPassword: true, controller: controller.signUpPasswordController),
        const SizedBox(height: 20),
        MESATextField(hintText: "Password Check", prefixIcon: Icons.key, isPassword: true, controller: controller.passwordCheckController),
        const SizedBox(height: 20),
        Row(
          children: [
            Transform.scale(
              scale: 1.5,
              child: Checkbox(
                value: controller.check.value,
                onChanged: (value) => controller.check.value = value!,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                activeColor: MESAColors.mainColor,
              ),
            ),
            const SizedBox(width: 10),
            const Text("I agree to the terms and conditions", style: MESATextTheme.regular16),
          ],
        ),
        const SizedBox(height: 40),
        MouseRegion(
            cursor: SystemMouseCursors.click,
            child: MESASmallTextButton(
              text: "Sign Up",
              onTap: controller.signUp,
              color: MESAColors.mainColor,
            )),
        const SizedBox(height: 20),
        MouseRegion(
            cursor: SystemMouseCursors.click,
            child: MESASmallTextButton(
              text: "back to login",
              onTap: () => controller.isRegister.value = false,
              color: MESAColors.button,
            )),
      ],
    );
  }

  Column _login() {
    return Column(
      children: [
        MESATextField(hintText: "Login ID", controller: controller.idController),
        const SizedBox(height: 20),
        MESATextField(hintText: "Login PW", prefixIcon: Icons.lock, isPassword: true, controller: controller.passwordController),
        Obx(() => controller.loginError.value
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SvgPicture.asset("assets/svgs/exclaim.svg"),
                      const SizedBox(width: 8),
                      Text("Incorrect ID or PW", style: MESATextTheme.regular16.copyWith(color: const Color(0xffFF4646))),
                    ],
                  ),
                ],
              )
            : const SizedBox()),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: MESASmallTextButton(
                    text: "Login",
                    onTap: controller.login,
                    color: MESAColors.mainColor,
                  )),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: MESASmallTextButton(
                    text: "Login For Manager",
                    onTap: controller.loginForManager,
                    color: MESAColors.mainColor,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 20),
        MouseRegion(
            cursor: SystemMouseCursors.click,
            child: MESASmallTextButton(
              text: "Sign Up",
              onTap: () => controller.isRegister.value = true,
              color: MESAColors.button,
            )),
      ],
    );
  }
}
