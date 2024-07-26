import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  final String assetName;
  final Color? color;
  final double? width;
  final double? height;

  const AppIcon({super.key, required this.assetName, this.color, this.width,this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(color ?? Theme.of(context).iconTheme.color!, BlendMode.srcIn),
    );
  }
}
