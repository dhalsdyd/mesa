import 'package:flutter/material.dart';
import 'package:mesa/app/core/theme/color_theme.dart';
import 'package:mesa/app/core/theme/text_theme.dart';

class Header extends StatelessWidget {
  const Header({super.key, this.onlyLogo = false});

  final bool onlyLogo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/mesa_logo.png", width: 33, height: 33),
            const SizedBox(width: 10),
            const Text("MESA", style: MESATextTheme.boldMain32),
          ],
        ),
        const SizedBox(height: 2),
        if (!onlyLogo) const Text("Mission for Enhanced Security Advancement", style: MESATextTheme.medium16),
      ],
    );
  }
}

class ArticleHeader extends StatelessWidget {
  const ArticleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Image.asset("assets/images/moji_newlogo.png", width: 28, height: 28),
              const SizedBox(width: 10),
              const Text("MESA", style: MESATextTheme.boldMain26),
            ],
          ),
        ),
        const Divider(
          color: MESAColors.border,
          thickness: 2,
          height: 1,
        ),
      ],
    );
  }
}
