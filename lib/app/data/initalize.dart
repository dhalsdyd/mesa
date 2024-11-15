import 'package:moji_backoffice/app/data/controllers/lifecycle.dart';
import 'package:get/get.dart';
import 'package:moji_backoffice/app/data/local/getx_storage.dart';

class AppInitalizer {
  Future<void> init() async {
    Get.put<LocalDatabase>(LocalDatabase());
    //Get.put<LifeCycleController>(LifeCycleController());
    // await Get.putAsync<DatabaseController>(() => DatabaseController().init());
    // await Get.putAsync<AuthController>(() => AuthController().init());
  }
}
