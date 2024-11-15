import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moji_backoffice/app/core/theme/color_theme.dart';
import 'package:moji_backoffice/app/core/theme/text_theme.dart';

class MAMSCard extends StatelessWidget {
  const MAMSCard({super.key, required this.svgPath, required this.title, this.onTap});

  final String svgPath;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: MAMSColors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: MAMSColors.border, width: 1),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svgs/$svgPath"),
                const SizedBox(width: 8),
                Text(title, style: MAMSTextTheme.medium16),
              ],
            ),
            SvgPicture.asset("assets/svgs/right_arrow.svg"),
          ],
        ),
      ),
    );
  }
}
