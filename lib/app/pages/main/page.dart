import 'package:get/get.dart';
import 'package:mesa/app/core/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:mesa/app/pages/main/controller.dart';
import 'package:mesa/app/pages/main/widget/drawer.dart';
import 'package:mesa/app/widgets/header.dart';

class MainPage extends GetView<MainPageController> {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: MESAColors.background,
        appBar: constraints.maxWidth > 900
            ? null
            : AppBar(
                backgroundColor: MESAColors.background,
                elevation: 0,
                title: const Header(onlyLogo: true),
                leading: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: controller.openDrawer,
                ),
                scrolledUnderElevation: 0,
              ),
        drawer: MESADrawerTab(),
        body: Row(
          children: [
            if (constraints.maxWidth > 900) MESADrawerTab(),
            Expanded(
              child: Obx(() => controller.pages[controller.pageIndex]),
            ),
          ],
        ),
      );
    });
  }
}
