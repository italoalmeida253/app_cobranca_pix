import 'dart:math';

import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class AppDropdown extends StatefulWidget {
  final Widget triggerChild;
  final String? iconAssetName;
  final Widget child;

  const AppDropdown(
      {super.key,
      this.iconAssetName,
      required this.triggerChild,
      required this.child});

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: show ? 8 : 0),
          child: GestureDetector(
            onTap: () {
              debugPrint(show.toString());
              setState(() {
                show = !show;
              });
            },
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                widget.triggerChild,
                if (widget.iconAssetName != null)
                  Positioned(right: 16, child: Transform.rotate(angle: show ? pi : 0, child: AppIcon(assetName: widget.iconAssetName!)))
              ],
            ),
          ),
        ),
        if (show) widget.child
      ],
    );
  }
}
