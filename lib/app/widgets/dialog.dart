import 'package:moji_backoffice/app/core/theme/color_theme.dart';
import 'package:moji_backoffice/app/core/theme/text_theme.dart';
import 'package:moji_backoffice/app/widgets/button.dart';
import 'package:flutter/material.dart';

class MAMSDialogAction {
  final String title;
  final void Function()? onTap;
  final bool isHighlighted;
  MAMSDialogAction({required this.title, this.onTap, this.isHighlighted = false});
}

class MAMSDialogActionButton extends StatelessWidget {
  const MAMSDialogActionButton(this.action, {Key? key}) : super(key: key);
  final MAMSDialogAction action;

  @override
  Widget build(BuildContext context) {
    return MAMSMediumTextButton(
      text: action.title,
      onTap: action.onTap,
      color: action.isHighlighted ? MAMSColors.mainColor : MAMSColors.black,
    );
  }
}

class MAMSDialog extends StatelessWidget {
  const MAMSDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  final String title;
  final String content;

  final List<MAMSDialogAction> actions;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: MAMSTextTheme.boldMain20),
            const SizedBox(height: 12),
            Text(content, style: MAMSTextTheme.regular12),
            const SizedBox(height: 12),
            for (var action in actions)
              Column(
                children: [
                  const SizedBox(height: 12),
                  MAMSDialogActionButton(action),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
