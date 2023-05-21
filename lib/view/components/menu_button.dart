import 'dart:math';

import 'package:flutter/material.dart';

typedef MenuButtonCallbackFunction = void Function();

class MenuButton extends StatelessWidget {
  final String title;
  final Widget leading;
  final double spacing;
  final Size leadingWidgetSize;

  final MenuButtonCallbackFunction? onPress;

  const MenuButton({
    super.key,
    required this.title,
    required this.leading,
    this.spacing = 15,
    this.leadingWidgetSize = const Size(15, 15),
    this.onPress,
  });

  MenuButton.icon({
    super.key,
    required this.title,
    required IconData icon,
    this.spacing = 15,
    this.leadingWidgetSize = const Size(15, 15),
    this.onPress,
  }) : leading = Icon(
          icon,
          size: min(leadingWidgetSize.width, leadingWidgetSize.height),
        );

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPress,
        child: Row(
          children: [
            SizedBox(
              width: leadingWidgetSize.width,
              height: leadingWidgetSize.height,
              child: leading,
            ),
            SizedBox(width: spacing),
            Text(title),
          ],
        ),
      );
}
