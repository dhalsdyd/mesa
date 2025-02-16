import 'package:mesa/app/pages/home/binding.dart';
import 'package:mesa/app/pages/home/page.dart';
import 'package:mesa/app/pages/login/binding.dart';
import 'package:mesa/app/pages/login/page.dart';
import 'package:mesa/app/pages/main/binding.dart';
import 'package:mesa/app/pages/main/page.dart';
import 'package:mesa/app/pages/project/binding.dart';
import 'package:mesa/app/pages/project/page.dart';
import 'package:mesa/app/routes/route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => const HomePage(), binding: HomePageBinding()),
    GetPage(name: Routes.login, page: () => const LoginPage(), binding: LoginPageBinding()),
    GetPage(name: Routes.main, page: () => const MainPage(), binding: MainPageBinding()),
    GetPage(name: Routes.project, page: () => const ProjectPage(), binding: ProjectPageBinding()),
  ];
}
