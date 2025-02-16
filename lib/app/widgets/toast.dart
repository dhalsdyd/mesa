import 'package:fluttertoast/fluttertoast.dart';

class MESAToast {
  static void open(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
