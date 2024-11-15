import 'package:flutter/material.dart';
import 'package:moji_backoffice/app/core/theme/text_theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "This service can only be used by MOJI Admin, and may be punished according to the relevant laws when approaching by someone other than MOJI Admin. \n \n In addition, capturing and sharing the screen of this service or sharing the information of this service to the outside may be punished according to the relevant laws.",
          style: MAMSTextTheme.medium12,
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
