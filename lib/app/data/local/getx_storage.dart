import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Alternatives include have, shared_preferences, flutter_secure_storage, sqflite, moor and so on.

class LocalDatabase extends GetxService {
  GetStorage? box;

  @override
  void onInit() async {
    await GetStorage.init();
    box = GetStorage();
    super.onInit();
  }

  // Wait CallBack
  Future<void> waitWrite(String key, String value) async {
    await box!.write(key, value);
  }

  Future<void> waitRead(String key) async {
    await box!.read(key);
  }

  Future<void> waitRemove(String key) async {
    await box!.remove(key);
  }

  //Right Now!!!
  void write(String key, String value) {
    box!.write(key, value);
  }

  String? read(String key) {
    return box!.read(key);
  }

  bool hasData(String key) {
    return box!.hasData(key);
  }

  void remove(String key) {
    box!.remove(key);
  }

  void removeAll() {
    box!.erase();
  }
}
