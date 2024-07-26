import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class NoContentWarn extends StatelessWidget {
  final String iconAssetName;
  final String warn;

  const NoContentWarn(
      {super.key, required this.iconAssetName, required this.warn});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(
          assetName: iconAssetName,
          height: 100,
          color: Colors.white.withOpacity(.5),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          warn,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.merge(TextStyle(color: Colors.white)),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
