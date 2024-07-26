import 'package:app_cobranca_pix/main.dart';
import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class ActionItem extends StatelessWidget {
  final String label;
  final String iconAssetName;

  const ActionItem(
      {super.key, required this.label, required this.iconAssetName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .inverseSurface
                      .withOpacity(.21)))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIcon(
            assetName: iconAssetName,
            color: Theme.of(context).colorScheme.primary,
            width: 24,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.merge(TextStyle(
                color: MyApp.of(context).lightTheme
                    ? Colors.black
                    : Colors.white)),
          )
        ],
      ),
    );
  }
}
