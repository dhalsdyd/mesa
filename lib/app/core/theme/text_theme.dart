import 'package:mesa/app/core/theme/color_theme.dart';
import 'package:flutter/material.dart';

abstract class MESATextTheme {
  //Default Black
  //Name Rule
  //FontWeight + Color + Font Size

  static const bold20 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w700, fontSize: 20, color: MESAColors.black);
  static const bold24 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w700, fontSize: 20, color: MESAColors.black);
  static const boldMain20 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w700, fontSize: 20, color: MESAColors.mainColor);
  static const boldMain26 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w700, fontSize: 26, color: MESAColors.mainBlack);
  static const boldMain32 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w700, fontSize: 32, color: MESAColors.mainBlack);

  static const semiBold20 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w600, fontSize: 20, color: MESAColors.mainBlack);
  static const semiBold22 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w600, fontSize: 22, color: MESAColors.mainBlack);

  static const regular20 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w400, fontSize: 20, color: MESAColors.black);
  static const regular16 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w400, fontSize: 16, color: MESAColors.black);
  static const regular12 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w400, fontSize: 12, color: MESAColors.description);

  static const medium20 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w500, fontSize: 20, color: MESAColors.black);
  static const medium16 =
      TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w500, fontSize: 16, color: MESAColors.mainBlack, height: 1.5, letterSpacing: 0.0);
  static const medium12 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w500, fontSize: 12, color: MESAColors.description);
}
