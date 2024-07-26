import 'package:app_cobranca_pix/screens/add_key_screen.dart';
import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:app_cobranca_pix/widgets/button.dart';
import 'package:flutter/material.dart';

class AddKeyButton extends StatelessWidget {
  const AddKeyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, _, __) => const AddKeyScreen(),
              ));
        },
        label: 'Adicionar nova chave',
        icon: AppIcon(
          assetName: 'assets/images/plus.svg',
          color: Theme.of(context).colorScheme.primary,
        ));
  }
}
