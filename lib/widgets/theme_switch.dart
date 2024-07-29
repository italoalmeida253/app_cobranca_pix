import 'package:app_cobranca_pix/main.dart';
import 'package:app_cobranca_pix/theme/colors.dart';
import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              curve: Curves.fastEaseInToSlowEaseOut,
              left: MyApp.of(context).lightTheme ? 16 : 216,
              right: MyApp.of(context).lightTheme ? 216 : 16,
              child: SizedBox(
                width: 94,
                height: 40,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: MyApp.of(context).lightTheme ? terciaryColor : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    await MyApp.of(context).changeThemeMode(ThemeMode.light);
                  },
                  child: AppIcon(
                    assetName: 'assets/images/sun.svg',
                    color: MyApp.of(context).lightTheme ? Colors.white : secondaryColor,
                    height: 32,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await MyApp.of(context).changeThemeMode(ThemeMode.dark);
                  },
                  child: const AppIcon(
                    assetName: 'assets/images/moon.svg',
                    color: terciaryColor,
                    width: 32,
                    height: 32,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


/*  */