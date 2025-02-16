import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mesa/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:mesa/app/pages/project/controller.dart';
import 'package:mesa/app/widgets/button.dart';

class ProjectPage extends GetView<ProjectPageController> {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(40),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("MESA Project", style: MESATextTheme.boldMain32),
                const Text("Mission for Enhanced Security Advancement", style: MESATextTheme.medium16),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
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
                                      const Expanded(
                                        child: Row(
                                          children: [
                                            Text("user", style: MESATextTheme.bold24),
                                            SizedBox(width: 10),
                                            Text("Update File 1", style: MESATextTheme.medium16),
                                          ],
                                        ),
                                      ),
                                      const Text("2 weeks ago", style: MESATextTheme.medium16),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          // Show options
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const AlertDialog(
                                                title: Text("Options"),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      leading: Icon(Icons.timeline),
                                                      title: Text("View History"),
                                                    ),
                                                    ListTile(
                                                      leading: Icon(Icons.edit),
                                                      title: Text("Edit"),
                                                    ),
                                                    ListTile(
                                                      leading: Icon(Icons.delete),
                                                      title: Text("Delete"),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: const Icon(Icons.more_vert),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.lock_clock),
                                title: const Text("01/04 - AGENDA"),
                                subtitle: Text("Folder Upated ${getDateTimeDifference(DateTime(2025, 1, 4))} weeks ago"),
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.lock_clock),
                                title: const Text("01/18 - 2nd AGENDA"),
                                subtitle: Text("Folder Upated ${getDateTimeDifference(DateTime(2025, 1, 18))} weeks ago"),
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.lock_clock),
                                title: const Text("01/25 - 3rd AGENDA"),
                                subtitle: Text("Folder Upated ${getDateTimeDifference(DateTime(2025, 1, 25))} weeks ago"),
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.lock_clock),
                                title: const Text("02/08- 4th AGENDA"),
                                subtitle: Text("Folder Upated ${getDateTimeDifference(DateTime(2025, 2, 8))} weeks ago"),
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.file_copy),
                                title: const Text("기획서 세부 사항 (Importance 3)"),
                                subtitle: const Text("File Uploaded 8 weeks ago"),
                                trailing: const Icon(Icons.download),
                                tileColor: Colors.red[100],
                                onTap: () => controller.downloadFileWithMesa(3),
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.file_copy),
                                title: const Text("신청서 양식 (Importance 2)"),
                                subtitle: const Text("File Uploaded 8 weeks ago"),
                                trailing: const Icon(Icons.download),
                                tileColor: Colors.yellow[100],
                                onTap: () => controller.downloadFileWithMesa(2),
                              ),
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.file_copy),
                                title: const Text("공모 주제 (Importance 1)"),
                                subtitle: const Text("File Uploaded 8 weeks ago"),
                                trailing: const Icon(Icons.download),
                                tileColor: Colors.green[100],
                                onTap: () => controller.downloadFileWithMesa(1),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("* 다운로드 하는데 시간이 걸릴 수 있습니다"),
                        const SizedBox(height: 40),
                        const Text("Decrypte File", style: MESATextTheme.bold20),
                        const Text("* 복호화 하는데 시간이 걸릴 수 있습니다"),
                        const SizedBox(height: 10),
                        MESAMediumTextButton(
                            text: "Decrypte",
                            onTap: () {
                              controller.mesaService.decryptTextFile();
                            }),
                        const SizedBox(height: 40),
                        SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
                              DropzoneView(
                                operation: DragOperation.copy,
                                cursor: CursorType.grab,
                                onHover: () {
                                  controller.onDrop.value = true;
                                },
                                onLeave: () {
                                  controller.onDrop.value = false;
                                },
                              ),
                              Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: controller.onDrop.value ? Colors.green : Colors.grey),
                                    color: controller.onDrop.value ? Colors.green[100] : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.cloud_upload, size: 50),
                                        Text("Drop files here For Update", style: MESATextTheme.medium16),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Downloading File...", style: MESATextTheme.medium16),
                  ],
                );
              } else {
                return const SizedBox();
              }
            })
          ],
        ),
      )),
    );
  }

  int getDateTimeDifference(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    return difference.inDays ~/ 7;
  }
}
