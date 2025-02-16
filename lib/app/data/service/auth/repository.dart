import 'package:mesa/app/data/provider/api_interface.dart';

class AuthRepository {
  final MESAApiInterface api;

  AuthRepository(this.api);

  Future<Map> login(String id, String password) async {
    return await api.login(id, password);
  }
}
