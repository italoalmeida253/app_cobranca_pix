import 'package:app_cobranca_pix/theme/colors.dart';
import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:flutter/material.dart';

enum ButtonTypes { standard, rounded, transparent }

class Button extends StatelessWidget {
  final String label;
  final ButtonTypes type;
  final AppIcon? icon;
  final Function()? onTap;

  const Button(
      {super.key,
      required this.label,
      this.type = ButtonTypes.standard,
      this.onTap,
      this.icon});

  @override
  Widget build(BuildContext context) {
    late BorderRadius borderRadius;
    Color backgroundColor = Theme.of(context).colorScheme.surface;
    Color overlayColor = terciaryColor.withOpacity(.25);
    Color textColor = Theme.of(context).colorScheme.primary;

    switch (type) {
      case ButtonTypes.standard:
        borderRadius = BorderRadius.circular(12);
        break;
      case ButtonTypes.rounded:
        borderRadius = BorderRadius.circular(100);
        break;
      case ButtonTypes.transparent:
        borderRadius = BorderRadius.zero;
        backgroundColor = Colors.transparent;
        textColor = Colors.white;
        overlayColor = Colors.white.withOpacity(.25);
        borderRadius = BorderRadius.circular(100);
        break;
    }

    return ElevatedButton(
      onPressed: () {
        if (onTap != null) {
          onTap!();
        }
      },
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: borderRadius)),
          padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
          backgroundColor: MaterialStatePropertyAll(backgroundColor),
          elevation: const MaterialStatePropertyAll(0),
          overlayColor: MaterialStatePropertyAll(overlayColor),
          shadowColor: MaterialStatePropertyAll(Colors.black.withOpacity(.10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          const SizedBox(
            width: 8,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.merge(
                TextStyle(color: textColor, fontWeight: FontWeight.w800)),
          )
        ],
      ),
    );
  }
}
