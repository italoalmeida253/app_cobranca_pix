import 'package:app_cobranca_pix/theme/colors.dart';
import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class SettingsItemTile extends StatelessWidget {
  final String label;
  final String iconAssetName;

  const SettingsItemTile(
      {super.key, required this.label, required this.iconAssetName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Colors.white.withOpacity(.36), width: 1))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          AppIcon(assetName: iconAssetName, color: terciaryColor, height: 28,),
          const SizedBox(
            width: 12,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
