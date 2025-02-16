import 'package:get/get.dart';

class Project {
  final String name;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Project({
    required this.name,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}

class HomePageController extends GetxController with StateMixin {
  static HomePageController get to => Get.find<HomePageController>(); // add this line

  final projects = <Project>[
    Project(
      name: "MESA Project",
      description: "Mission for Enhanced Security Advancement",
      status: "Active",
      createdAt: DateTime(2025, 1, 4),
      updatedAt: DateTime.now(),
    ),
    Project(
      name: "Aegis Initiative",
      description: "Advanced AI-driven cybersecurity framework",
      status: "Active",
      createdAt: DateTime(2024, 11, 12),
      updatedAt: DateTime.now(),
    ),
    Project(
      name: "Sentinel Program",
      description: "Automated threat detection and response system",
      status: "In Development",
      createdAt: DateTime(2024, 9, 30),
      updatedAt: DateTime.now(),
    ),
    Project(
      name: "CyberShield",
      description: "Next-generation firewall and intrusion prevention",
      status: "Completed",
      createdAt: DateTime(2023, 6, 15),
      updatedAt: DateTime(2024, 12, 20),
    ),
    Project(
      name: "Horizon Watch",
      description: "Predictive analytics for cybersecurity threats",
      status: "Active",
      createdAt: DateTime(2025, 1, 20),
      updatedAt: DateTime.now(),
    ),
    Project(
      name: "Fortress-X",
      description: "Secure cloud infrastructure for enterprise data",
      status: "Paused",
      createdAt: DateTime(2023, 3, 10),
      updatedAt: DateTime(2024, 8, 5),
    ),
  ].obs;
}
