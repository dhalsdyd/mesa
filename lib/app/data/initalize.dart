import 'package:get/get.dart';
import 'package:mesa/app/data/local/getx_storage.dart';
import 'package:mesa/app/data/provider/api.dart';
import 'package:mesa/app/data/service/auth/repository.dart';
import 'package:mesa/app/data/service/auth/service.dart';
import 'package:mesa/app/data/service/mesa/service.dart';

class AppInitalizer {
  Future<void> init() async {
    Get.put<LocalDatabase>(LocalDatabase());
    Get.put<MesaService>(MesaService());
    await Future.wait([
      Get.putAsync(() => AuthService(AuthRepository(MESAApiProvider())).init()),
    ]);
  }
}
