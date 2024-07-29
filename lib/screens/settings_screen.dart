import 'package:app_cobranca_pix/widgets/app_container.dart';
import 'package:app_cobranca_pix/widgets/settings_item_tile.dart';
import 'package:app_cobranca_pix/widgets/theme_switch.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 300,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 48),
                decoration: const BoxDecoration(
                  color: Colors.white
                ),
                child: Text(
                  'Configurações',
                  style: Theme.of(context).textTheme.displayLarge?.merge(const TextStyle(color: Colors.black)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 48),
              constraints: const BoxConstraints(
                maxHeight: 596
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tema',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          'Escolha um tema do seu agrado',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 12,),
                        ThemeSwitch(),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Sobre o Aplicativo',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    children: [
                      SettingsItemTile(
                          label: 'Política de Privacidade',
                          iconAssetName: 'assets/images/shield.svg'),
                      SettingsItemTile(
                          label: 'Termos de Uso',
                          iconAssetName: 'assets/images/file.svg'),
                      SettingsItemTile(
                          label: 'Avaliar o App',
                          iconAssetName: 'assets/images/star.svg'),
                      SettingsItemTile(
                          label: 'Compartilhe',
                          iconAssetName: 'assets/images/share.svg')
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
