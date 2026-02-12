import 'package:blablacar/ui/theme/theme.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

/// BlaButton is a customizable button widget used throughout the app.
/// It supports two types:
/// - primary: main action button with colored background and white text
/// - secondary: outlined button with white background and colored text

class BlaButton extends StatelessWidget {
  const BlaButton({
    super.key,
    required this.type, // Type of button (primary or secondary)
    required this.label, // Text label to display inside the button
    this.icon, // Optional icon to show next to the label
    required this.onTap, // Callback function executed when the button is pressed
  });

  final ButtonType type;
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  /// Returns the background color depending on the button type
  Color get backgroundColor {
    switch (type) {
      case ButtonType.primary:
        return BlaColors.primary; // Primary button has main app color
      case ButtonType.secondary:
        return BlaColors.white; // Secondary button has white background
    }
  }

  /// Returns the foreground/text color depending on the button type
  Color get foregroundColor {
    switch (type) {
      case ButtonType.primary:
        return BlaColors.white; // White text for primary button
      case ButtonType.secondary:
        return BlaColors.primary; // Primary color text for secondary button
    }
  }

  /// Returns the border style depending on the button type
  BorderSide get borderSide {
    switch (type) {
      case ButtonType.primary:
        return BorderSide.none; // No border for primary button
      case ButtonType.secondary:
        return BorderSide(color: BlaColors.neutralLighter, width: 1); // Light border for secondary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(BlaSpacings.l),
      child: ElevatedButton(
        onPressed: onTap, // Trigger callback when pressed
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: BlaSpacings.l),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radiusLarge),
            side: borderSide,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon), // Show icon if provided
            if (icon != null) SizedBox(width: BlaSpacings.s), // Small spacing between icon and label
            Text(label, style: BlaTextStyles.button),
          ],
        ),
      ),
    );
  }
}
