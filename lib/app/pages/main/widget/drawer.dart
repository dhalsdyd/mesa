import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa/app/core/theme/color_theme.dart';
import 'package:mesa/app/core/theme/text_theme.dart';
import 'package:mesa/app/pages/main/controller.dart';
import 'package:mesa/app/widgets/header.dart';

class MESADrawerTab extends StatelessWidget {
  MESADrawerTab({super.key});

  final MainPageController controller = Get.find<MainPageController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      shape: const RoundedRectangleBorder(),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Header(onlyLogo: true),
            const Divider(),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  return Column(
                    children: [
                      MESADrawerItem(
                        icon: Icons.folder,
                        text: "Project",
                        isSelected: controller.pageIndex == 0,
                        onTap: () {
                          controller.changePage(0);
                        },
                      ),
                      const SizedBox(height: 20),
                      MESADrawerItem(
                        icon: Icons.dashboard,
                        text: "Dashboard",
                        isSelected: controller.pageIndex == 1,
                        onTap: () {
                          controller.changePage(1);
                        },
                      ),
                      const SizedBox(height: 20),
                      MESADrawerItem(
                        icon: Icons.person,
                        text: "Permission",
                        isSelected: controller.pageIndex == 2,
                        onTap: () {
                          controller.changePage(2);
                        },
                      ),
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MESADrawerItem extends StatelessWidget {
  const MESADrawerItem({super.key, required this.icon, required this.text, required this.isSelected, this.onTap});

  final IconData icon;
  final String text;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: isSelected ? MESAColors.mainColor : Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 80,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(text, style: MESATextTheme.bold20),
      ],
    );
  }
}
