import 'package:app_cobranca_pix/constants/index.dart';
import 'package:app_cobranca_pix/screens/create_billing_screen.dart';
import 'package:app_cobranca_pix/screens/home_screen.dart';
import 'package:app_cobranca_pix/screens/keys_screen.dart';
import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:app_cobranca_pix/widgets/navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:app_cobranca_pix/screens/settings_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: navbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavbarItem(
              linkTo: HomeScreen(),
              icon: AppIcon(
                assetName: 'assets/images/house.svg',
                height: 20,
              ),
              label: 'Início'),
          NavbarItem(
              linkTo: KeysScreen(),
              icon: AppIcon(
                assetName: 'assets/images/key.svg',
                height: 20,
              ),
              label: 'Chaves'),
          NavbarItem(
              linkTo: CreateBillingScreen(),
              icon: AppIcon(
                assetName: 'assets/images/qr.svg',
                height: 20,
              ),
              label: 'Cobranças'),
          NavbarItem(
              linkTo: SettingsScreen(),
              icon: AppIcon(
                assetName: 'assets/images/gear.svg',
                height: 20,
              ),
              label: 'Configurações'),
        ],
      ),
    );
  }
}
