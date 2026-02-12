import 'package:blablacar/ui/theme/theme.dart';
import 'package:blablacar/ui/widgets/actions/bla_icon_button.dart';
import 'package:flutter/material.dart';

class RidePrefsInput extends StatelessWidget {
  final String title;
  final IconData leftIcon;
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;
  final bool isInput;
  final VoidCallback onPressed;

  const RidePrefsInput({
    super.key,
    required this.title,
    required this.leftIcon,
    required this.onPressed,
    this.isInput = false,
    this.rightIcon,
    this.onRightIconPressed,
  });

  Color get titleColor => isInput ? BlaColors.textLight : BlaColors.textNormal;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(title, style: BlaTextStyles.label.copyWith(color: titleColor),),
      leading: Icon(
        leftIcon,
        size: 24,
        color: BlaColors.iconLight,
      ),
      trailing: rightIcon == null
        ? null
        : BlaIconButton(icon: rightIcon!, onPressed: onRightIconPressed),
    );
  }
}
