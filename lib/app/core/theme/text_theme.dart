import 'package:moji_backoffice/app/core/theme/color_theme.dart';
import 'package:flutter/material.dart';

abstract class MAMSTextTheme {
  //Default Black
  //Name Rule
  //FontWeight + Color + Font Size

  static const bold20 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w700, fontSize: 20, color: MAMSColors.black);
  static const boldMain20 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w700, fontSize: 20, color: MAMSColors.mainColor);
  static const boldMain26 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w700, fontSize: 26, color: MAMSColors.mainBlack);
  static const boldMain32 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w700, fontSize: 32, color: MAMSColors.mainBlack);

  static const semiBold20 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w600, fontSize: 20, color: MAMSColors.mainBlack);
  static const semiBold22 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w600, fontSize: 22, color: MAMSColors.mainBlack);

  static const regular20 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w400, fontSize: 20, color: MAMSColors.black);
  static const regular16 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w400, fontSize: 16, color: MAMSColors.black);
  static const regular12 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w400, fontSize: 12, color: MAMSColors.black);

  static const medium20 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w500, fontSize: 20, color: MAMSColors.black);
  static const medium16 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w500, fontSize: 16, color: MAMSColors.mainBlack);
  static const medium12 = TextStyle(fontFamily: "Pretendard", fontWeight: FontWeight.w500, fontSize: 12, color: MAMSColors.description);
}
