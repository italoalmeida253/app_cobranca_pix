import 'package:app_cobranca_pix/theme/colors.dart';
import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final String label;
  final String iconAssetName;
  final Function()? onTap;

  const ButtonIcon(
      {super.key,
      required this.label,
      required this.iconAssetName,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onTap != null) {
          onTap!();
        }
      },
      style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Theme.of(context).colorScheme.surface),
          padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
                    elevation: const MaterialStatePropertyAll(0),
          overlayColor: MaterialStatePropertyAll(terciaryColor.withOpacity(.25)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)))),
      child: Column(
        children: [
          AppIcon(
            assetName: iconAssetName,
            height: 27,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700)),
          )
        ],
      ),
    );
  }
}
