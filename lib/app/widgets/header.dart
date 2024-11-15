import 'package:flutter/material.dart';
import 'package:moji_backoffice/app/core/theme/color_theme.dart';
import 'package:moji_backoffice/app/core/theme/text_theme.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset("assets/images/moji_newlogo.png", width: 33, height: 33),
            const SizedBox(width: 10),
            const Text("MAMS", style: MAMSTextTheme.boldMain32),
          ],
        ),
        const SizedBox(height: 4),
        const Text("MOJI Article Management System", style: MAMSTextTheme.medium16),
      ],
    );
  }
}

class ArticleHeader extends StatelessWidget {
  const ArticleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Image.asset("assets/images/moji_newlogo.png", width: 28, height: 28),
              const SizedBox(width: 10),
              const Text("MAMS", style: MAMSTextTheme.boldMain26),
            ],
          ),
        ),
        Divider(
          color: MAMSColors.border,
          thickness: 1,
        ),
      ],
    );
  }
}
