import 'package:mesa/app/core/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mesa/app/core/theme/text_theme.dart';

class MESAIconButton extends StatelessWidget {
  final String iconPath;
  final int? badgeNumber;
  final void Function()? onTap;
  const MESAIconButton(this.iconPath, {this.badgeNumber, this.onTap, Key? key}) : super(key: key);

  Widget _badge() {
    if (badgeNumber != null) {
      return Positioned(
        top: 6,
        right: 6,
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: MESAColors.mainColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              badgeNumber.toString(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: MESAColors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(iconPath, color: MESAColors.mainColor),
                ),
              ),
            ),
            _badge(),
          ],
        ),
      ),
    );
  }
}

class MESAKeyboardReactiveButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsets innerPadding;
  final EdgeInsets padding;
  final void Function()? onTap;
  final Color color;
  final bool disabled;
  const MESAKeyboardReactiveButton({
    Key? key,
    required this.child,
    this.width,
    this.innerPadding = const EdgeInsets.all(16),
    this.onTap,
    this.padding = const EdgeInsets.all(0),
    this.color = MESAColors.mainColor,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (_, isKeyboardVisible) {
        double begin, end;
        if (isKeyboardVisible) {
          begin = 0;
          end = 1;
        } else {
          begin = 1;
          end = 0;
        }
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: begin, end: end),
          duration: const Duration(milliseconds: 100),
          builder: (context, value, _) {
            return Padding(
              padding: EdgeInsets.only(
                top: padding.top * (1 - value),
                bottom: padding.bottom * (1 - value),
                left: padding.left * (1 - value),
                right: padding.right * (1 - value),
              ),
              child: Opacity(
                opacity: disabled ? 0.6 : 1,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(color.r.toInt(), color.g.toInt(), color.b.toInt(), 0.24), offset: const Offset(0, 4), blurRadius: 12)
                    ],
                    borderRadius: BorderRadius.circular(12 * (1 - value)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12 * (1 - value)),
                    child: Material(
                      color: color,
                      child: InkWell(
                        onTap: disabled ? null : onTap,
                        child: Container(
                          width: width,
                          padding: innerPadding,
                          child: Center(
                            child: child,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MESABaseButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsets padding;
  final void Function()? onTap;
  final Color color;
  final bool disabled;
  const MESABaseButton(
      {Key? key, required this.child, required this.padding, this.onTap, this.width, this.color = MESAColors.mainColor, this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.6 : 1,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(color.r.toInt(), color.g.toInt(), color.b.toInt(), 0.24), offset: const Offset(0, 4), blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(6),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Material(
            color: color,
            child: InkWell(
              onTap: disabled ? null : onTap,
              child: Container(
                width: width,
                padding: padding,
                child: Center(
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MESALargeButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final void Function()? onTap;
  final Color color;
  final bool disabled;
  const MESALargeButton({
    Key? key,
    required this.child,
    this.onTap,
    this.width,
    this.color = MESAColors.mainColor,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MESABaseButton(
      padding: const EdgeInsets.all(24),
      width: width,
      onTap: onTap,
      color: color,
      disabled: disabled,
      child: child,
    );
  }
}

class MESALargeTextButton extends StatelessWidget {
  final String text;
  final double? width;
  final void Function()? onTap;
  final Color color;
  final Color textColor;
  final bool disabled;
  const MESALargeTextButton({
    Key? key,
    required this.text,
    this.onTap,
    this.width,
    this.color = MESAColors.mainColor,
    this.textColor = Colors.white,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MESALargeButton(
      width: width,
      onTap: onTap,
      color: color,
      disabled: disabled,
      child: Text(text, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}

class MESAMediumButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final void Function()? onTap;
  final Color color;
  final bool disabled;
  const MESAMediumButton({
    Key? key,
    required this.child,
    this.onTap,
    this.width,
    this.color = MESAColors.mainColor,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MESABaseButton(
      padding: const EdgeInsets.all(16),
      width: width,
      onTap: onTap,
      color: color,
      disabled: disabled,
      child: child,
    );
  }
}

class MESAMediumTextButton extends StatelessWidget {
  final String text;
  final double? width;
  final void Function()? onTap;
  final Color color;
  final Color textColor;
  final bool disabled;
  const MESAMediumTextButton({
    Key? key,
    required this.text,
    this.onTap,
    this.width,
    this.color = MESAColors.mainColor,
    this.textColor = Colors.white,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MESAMediumButton(
      width: width,
      onTap: onTap,
      color: color,
      disabled: disabled,
      child: Text(text, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}

class MESASmallButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final void Function()? onTap;
  final Color color;
  final bool disabled;
  const MESASmallButton({
    Key? key,
    required this.child,
    this.onTap,
    this.width,
    this.color = MESAColors.mainColor,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MESABaseButton(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: width,
      onTap: onTap,
      color: color,
      disabled: disabled,
      child: child,
    );
  }
}

class MESASmallTextButton extends StatelessWidget {
  final String text;
  final double? width;
  final void Function()? onTap;
  final Color color;
  final Color textColor;
  final bool disabled;
  const MESASmallTextButton({
    Key? key,
    required this.text,
    this.onTap,
    this.width,
    this.color = MESAColors.button,
    this.textColor = Colors.white,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MESASmallButton(
      width: width,
      onTap: onTap,
      color: color,
      disabled: disabled,
      child: Text(text, style: MESATextTheme.medium16.copyWith(color: textColor)),
    );
  }
}
