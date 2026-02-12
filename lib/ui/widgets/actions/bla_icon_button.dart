import 'package:blablacar/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  const BlaIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, 
      icon: Icon(icon, size: 24, color: BlaColors.primary,)
    );
  }
}
