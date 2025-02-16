import 'package:get/get.dart';
import 'package:mesa/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:mesa/app/pages/home/controller.dart';
import 'package:mesa/app/routes/route.dart';
import 'package:mesa/app/widgets/snackbar.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Management by project", style: MESATextTheme.boldMain32),
            const Text("Make Safer!", style: MESATextTheme.medium16),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
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
                      final project = controller.projects[index];
                      return mesaGridViewItem(project);
                    },
                    itemCount: controller.projects.length,
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    final project = controller.projects[index];
                    return mesaGridViewItem(project);
                  },
                  itemCount: controller.projects.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget mesaGridViewItem(Project project) {
    return GestureDetector(
      onTap: () {
        if (project.name == "MESA Project") {
          Get.toNamed(Routes.project);
        } else {
          MESAErrorSnackBar().open(
            "[Permission Denied] You do not have permission to access this project",
          );
        }
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.name, style: MESATextTheme.boldMain26),
                Text(project.description, style: MESATextTheme.medium16),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Status", style: MESATextTheme.medium16),
                    const SizedBox(width: 8),
                    statusText(project.status),
                  ],
                ),
                const SizedBox(height: 20),
                const Expanded(child: SizedBox()),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("created at", style: MESATextTheme.medium16),
                    const SizedBox(width: 4),
                    Text(dateFormat(project.createdAt), style: MESATextTheme.medium12),
                  ],
                ),
                Row(
                  children: [
                    const Text("updated at", style: MESATextTheme.medium16),
                    const SizedBox(width: 4),
                    Text(dateFormat(project.updatedAt), style: MESATextTheme.medium12),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  String dateFormat(DateTime date) {
    return "${date.year}.${date.month.toString().padLeft(2, "0")}.${date.day.toString().padLeft(2, "0")}";
  }

  Widget statusText(String status) {
    Color color;
    switch (status) {
      case "Active":
        color = Colors.green;
        break;
      case "Paused":
        color = Colors.red;
        break;
      case "Completed":
        color = Colors.grey;
        break;
      case "In Development":
        color = Colors.orange;
        break;
      default:
        color = Colors.blue;
    }

    return Text(status, style: MESATextTheme.medium16.copyWith(color: color));
  }
}
