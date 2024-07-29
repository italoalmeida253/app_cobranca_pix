import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavbarItem extends StatelessWidget {
  final String iconAssetName;
  final String label;
  final Widget linkTo;
  final String routeName;
  final bool focused;
  final Color focusedColor = const Color(0xFF13AD9C);

  const NavbarItem(
      {super.key,
      required this.iconAssetName,
      required this.label,
      required this.linkTo,
      required this.routeName,
      this.focused = false});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
            settings: RouteSettings(
              name: routeName,
            ),
            pageBuilder: (context, _, __) => linkTo,
            transitionDuration: Duration.zero),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(
            assetName: iconAssetName,
            height: 21,
            color: focused
                ? focusedColor
                : Theme.of(context).colorScheme.inverseSurface,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            label,
            style: GoogleFonts.sora(
                textStyle: TextStyle(
              fontSize: 11,
              color: focused
                  ? focusedColor
                  : Theme.of(context).colorScheme.inverseSurface,
            )),
          )
        ],
      ),
    );
  }
}
