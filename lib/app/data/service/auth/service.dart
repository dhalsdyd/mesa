import 'dart:async';
import 'package:mesa/app/data/service/auth/repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final AuthRepository repository;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final Rx<String?> _id = Rx('');
  final Rx<String?> _password = Rx('');
  final Rx<String?> _name = Rx('');
  final Rx<DateTime?> _lastLogin = Rx(DateTime.now());
  final Rx<String> written = ''.obs;

  bool get isAuthenticated => _id.value != null;

  String? get id => _id.value;
  String? get password => _password.value;
  String? get name => _name.value;
  DateTime? get lastLogin => _lastLogin.value;

  AuthService(this.repository);

  Future<AuthService> init() async {
    _id.value = await _storage.read(key: 'id');
    _password.value = await _storage.read(key: 'password');
    _name.value = await _storage.read(key: 'name');
    _lastLogin.value = DateTime.parse(await _storage.read(key: 'lastLogin') ?? DateTime.now().toString());

    return this;
  }

  Future<void> _setId(String id) async {
    await _storage.write(key: 'id', value: id);
    _id.value = id;
  }

  Future<void> _setPassword(String password) async {
    await _storage.write(key: 'password', value: password);
    _password.value = password;
  }

  Future<void> login(String id, String password) async {
    await _setId(id);
    await _setPassword(password);
    _name.value = "MESA $id";
    await _storage.write(key: 'name', value: "MESA $id");
  }

  Future<bool> getState() async {
    if (id != null && password != null) {
      final response = await repository.login(id!, password!);
      if (response['value'] == 'Success') {
        if (response.containsKey('texts')) {
          written.value = response['texts'];
          return true;
        }
      }
    }
    return false;
  }

  Future<void> logout() async {
    _id.value = null;
    _password.value = null;

    await _storage.delete(key: 'id');
    await _storage.delete(key: 'password');
    await _storage.delete(key: 'name');
    await _storage.delete(key: 'lastLogin');
  }
}
