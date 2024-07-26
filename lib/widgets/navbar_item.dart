import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class NavbarItem extends StatelessWidget {
  final AppIcon icon;
  final String label;
  final Widget linkTo;

  const NavbarItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.linkTo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, _, __) => linkTo,
            transitionDuration: Duration.zero),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(
            height: 4,
          ),
          Text(
            label,
            style: GoogleFonts.sora(textStyle: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.inverseSurface)),
          )
        ],
      ),
    );
  }
}
