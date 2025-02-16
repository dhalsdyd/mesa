import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesa/app/data/service/auth/service.dart';
import 'package:mesa/app/pages/dashboard/page.dart';
import 'package:mesa/app/pages/home/page.dart';
import 'package:mesa/app/pages/permission/page.dart';

class MainPageController extends GetxController with StateMixin {
  static MainPageController get to => Get.find<MainPageController>(); // add this line
  final AuthService authService = Get.find<AuthService>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String get userName => authService.name ?? '';

  Rx<bool> isSmallScreen = false.obs;

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  final _pageIndex = 0.obs;
  int get pageIndex => _pageIndex.value;

  List<Widget> pages = [
    const HomePage(),
    const DashboardPage(),
    const PermissionPage(),
  ];

  void changePage(int index) {
    if (_pageIndex.value == index) return;
    _pageIndex(index);
    //Get.offAllNamed(_pages[index], id: _navigatorKey);
  }

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.success());
  }
}
