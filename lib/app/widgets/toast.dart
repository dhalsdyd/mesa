import 'package:fluttertoast/fluttertoast.dart';

class MAMSToast {
  static void open(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
