import 'package:app_cobranca_pix/constants/index.dart';
import 'package:app_cobranca_pix/screens/create_billing_screen.dart';
import 'package:app_cobranca_pix/screens/home_screen.dart';
import 'package:app_cobranca_pix/screens/keys_screen.dart';
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
    final String? currentPath = ModalRoute.of(context)?.settings.name;

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
              linkTo: const HomeScreen(),
              routeName: '/',
              focused: '/' == currentPath,
              iconAssetName: 'assets/images/house.svg',
              label: 'Início'),
          NavbarItem(
              linkTo: const KeysScreen(),
              routeName: '/keys',
              focused: '/keys' == currentPath,
              iconAssetName: 'assets/images/key.svg',
              label: 'Chaves'),
          NavbarItem(
              linkTo: const CreateBillingScreen(),
              routeName: '/create-billing',
              focused: '/create-billing' == currentPath,
              iconAssetName: 'assets/images/qr.svg',
              label: 'Cobranças'),
          NavbarItem(
              linkTo: const SettingsScreen(),
              routeName: '/settings',
              focused: '/settings' == currentPath,
              iconAssetName: 'assets/images/gear.svg',
              label: 'Configurações'),
        ],
      ),
    );
  }
}
