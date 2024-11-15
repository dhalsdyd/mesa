import 'package:moji_backoffice/app/pages/articleView/binding.dart';
import 'package:moji_backoffice/app/pages/articleView/page.dart';
import 'package:moji_backoffice/app/pages/articleWrite/binding.dart';
import 'package:moji_backoffice/app/pages/articleWrite/page.dart';
import 'package:moji_backoffice/app/pages/home/binding.dart';
import 'package:moji_backoffice/app/pages/home/page.dart';
import 'package:moji_backoffice/app/pages/login/binding.dart';
import 'package:moji_backoffice/app/pages/login/page.dart';
import 'package:moji_backoffice/app/pages/main/binding.dart';
import 'package:moji_backoffice/app/pages/main/page.dart';
import 'package:moji_backoffice/app/routes/route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => const HomePage(), binding: HomePageBinding()),
    GetPage(name: Routes.login, page: () => const LoginPage(), binding: LoginPageBinding()),
    GetPage(name: Routes.main, page: () => const MainPage(), binding: MainPageBinding()),
    GetPage(name: Routes.articleWrite, page: () => const ArticleWritePage(), binding: ArticleWritePageBinding()),
    GetPage(name: Routes.articleView, page: () => const ArticleViewPage(), binding: ArticleViewPageBinding()),
  ];
}
