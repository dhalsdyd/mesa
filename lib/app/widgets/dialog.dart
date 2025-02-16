import 'package:mesa/app/core/theme/color_theme.dart';
import 'package:mesa/app/core/theme/text_theme.dart';
import 'package:mesa/app/widgets/button.dart';
import 'package:flutter/material.dart';

class MESADialogAction {
  final String title;
  final void Function()? onTap;
  final bool isHighlighted;
  MESADialogAction({required this.title, this.onTap, this.isHighlighted = false});
}

class MESADialogActionButton extends StatelessWidget {
  const MESADialogActionButton(this.action, {Key? key}) : super(key: key);
  final MESADialogAction action;

  @override
  Widget build(BuildContext context) {
    return MESAMediumTextButton(
      text: action.title,
      onTap: action.onTap,
      color: action.isHighlighted ? MESAColors.mainColor : MESAColors.black,
    );
  }
}

class MESADialog extends StatelessWidget {
  const MESADialog({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  final String title;
  final String content;

  final List<MESADialogAction> actions;

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
            Text(title, style: MESATextTheme.boldMain20),
            const SizedBox(height: 12),
            Text(content, style: MESATextTheme.regular12),
            const SizedBox(height: 12),
            for (var action in actions)
              Column(
                children: [
                  const SizedBox(height: 12),
                  MESADialogActionButton(action),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
