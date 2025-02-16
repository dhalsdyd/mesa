import 'package:get/get.dart';
import 'package:mesa/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:mesa/app/pages/permission/controller.dart';

class PermissionPage extends GetView<PermissionPageController> {
  const PermissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Permission Manager", style: MESATextTheme.boldMain32),
            const Text("Make Safer!", style: MESATextTheme.medium16),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LayoutBuilder(builder: (context, constraints) {
                      if (constraints.maxWidth < 800) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(20),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) {
                            final permission = controller.permissions[index];
                            return MESAGridViewItem(permission);
                          },
                          itemCount: controller.permissions.length,
                        );
                      }
                      return GridView.builder(
                        padding: const EdgeInsets.all(20),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          final permission = controller.permissions[index];
                          return MESAGridViewItem(permission);
                        },
                        itemCount: controller.permissions.length,
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class MESAGridViewItem extends StatelessWidget {
  final Permission permission;

  const MESAGridViewItem(this.permission, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(permission.name, style: MESATextTheme.bold24),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Permission", style: MESATextTheme.bold20),
                    Text(permission.permissions.toString(), style: MESATextTheme.medium16),
                    const SizedBox(height: 10),
                    const Text("Access Project", style: MESATextTheme.bold20),
                    Text(permission.accessProjects.toString(), style: MESATextTheme.medium16),
                    const SizedBox(height: 10),
                    const Text("Last Access", style: MESATextTheme.bold20),
                    Text(dateFormat(permission.lastAccessed), style: MESATextTheme.medium16),
                    const SizedBox(height: 10),
                    const Text("Last Update", style: MESATextTheme.bold20),
                    Text(dateFormat(permission.lastUpdated), style: MESATextTheme.medium16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String dateFormat(DateTime date) {
    return "${date.year}.${date.month.toString().padLeft(2, "0")}.${date.day.toString().padLeft(2, "0")}";
  }
}
