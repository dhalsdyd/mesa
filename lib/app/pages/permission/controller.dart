import 'package:get/get.dart';

class Permission {
  final String name;
  final List<String> permissions;
  final List<String> accessProjects;
  final DateTime lastAccessed;
  final DateTime lastUpdated;

  Permission({
    required this.name,
    required this.permissions,
    required this.accessProjects,
    required this.lastAccessed,
    required this.lastUpdated,
  });
}

class PermissionPageController extends GetxController with StateMixin {
  static PermissionPageController get to => Get.find<PermissionPageController>(); // add this line

  final permissions = <Permission>[
    Permission(
      name: "user",
      permissions: ["Read Only File"],
      accessProjects: ["MESA Project"],
      lastAccessed: DateTime.now(),
      lastUpdated: DateTime.now(),
    ),
    Permission(
      name: "Min",
      permissions: ["Read"],
      accessProjects: ["MESA Project"],
      lastAccessed: DateTime.now(),
      lastUpdated: DateTime.now(),
    ),
    Permission(
      name: "Eun",
      permissions: ["Read"],
      accessProjects: ["MESA Project"],
      lastAccessed: DateTime.now(),
      lastUpdated: DateTime.now(),
    ),
    Permission(
      name: "John Doe",
      permissions: ["Read", "Write", "Execute"],
      accessProjects: ["MESA Project", "Aegis Initiative", "Sentinel Program"],
      lastAccessed: DateTime(2025, 1, 4),
      lastUpdated: DateTime.now(),
    ),
    Permission(
      name: "Jane Smith",
      permissions: ["Read", "Write"],
      accessProjects: ["CyberShield", "Horizon Watch"],
      lastAccessed: DateTime(2025, 1, 20),
      lastUpdated: DateTime.now(),
    ),
    Permission(
      name: "Alice Johnson",
      permissions: ["Read"],
      accessProjects: ["Fortress-X"],
      lastAccessed: DateTime(2025, 2, 1),
      lastUpdated: DateTime.now(),
    ),
  ];
}
