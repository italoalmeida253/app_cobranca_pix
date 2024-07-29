import 'package:app_cobranca_pix/constants/index.dart';
import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:app_cobranca_pix/screens/add_key_screen.dart';
import 'package:app_cobranca_pix/screens/create_billing_screen.dart';
import 'package:app_cobranca_pix/services/isar.dart';
import 'package:app_cobranca_pix/widgets/action_item.dart';
import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:app_cobranca_pix/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class KeyCard extends StatelessWidget {
  final PixKey pixKey;
  final bool allowActions;

  const KeyCard({super.key, required this.pixKey, this.allowActions = true});

  @override
  Widget build(BuildContext context) {
    late String keyTypeLabel;

    switch (pixKey.type) {
      case PixKeyTypes.phone:
        keyTypeLabel = 'Celular';
        break;
      case PixKeyTypes.email:
        keyTypeLabel = 'Email';
        break;
      case PixKeyTypes.cpf:
        keyTypeLabel = 'CPF';
        break;
      case PixKeyTypes.cnpj:
        keyTypeLabel = 'CNPJ';
        break;
      case PixKeyTypes.randomKey:
        keyTypeLabel = 'Chave aleatória';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(38),
                  child: Image.asset(pixKey.bankLogo, height: 38,),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pixKey.description,
                        style: Theme.of(context).textTheme.displaySmall?.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface)),
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        pixKey.value,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodySmall?.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (allowActions)
                PopupMenuButton(
                  position: PopupMenuPosition.under,
                  padding: EdgeInsets.zero,
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  surfaceTintColor: Theme.of(context).colorScheme.surface,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: pixKey.value));
                        },
                        padding: EdgeInsets.zero,
                        child: const ActionItem(
                            label: 'Copiar chave',
                            iconAssetName: 'assets/images/copy-filled.svg')),
                    PopupMenuItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, _, __) =>
                                    CreateBillingScreen(
                                  pixKey: pixKey,
                                ),
                              ));
                        },
                        padding: EdgeInsets.zero,
                        child: const ActionItem(
                            label: 'Criar cobrança',
                            iconAssetName: 'assets/images/wallet.svg')),
                    PopupMenuItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, _, __) => AddKeyScreen(
                                  editPixKey: pixKey,
                                ),
                              ));
                        },
                        padding: EdgeInsets.zero,
                        child: const ActionItem(
                            label: 'Editar',
                            iconAssetName: 'assets/images/pencil.svg')),
                    PopupMenuItem(
                        onTap: () {
                          Share.share(pixKey.value);
                        },
                        padding: EdgeInsets.zero,
                        child: const ActionItem(
                            label: 'Compartilhar',
                            iconAssetName: 'assets/images/share.svg')),
                    PopupMenuItem(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              insetPadding: const EdgeInsets.all(24),
                              actionsPadding: const EdgeInsets.all(24),
                              actionsOverflowButtonSpacing: 8,
                              contentPadding: const EdgeInsets.only(
                                  left: 24, top: 24, right: 24),
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.surface,
                              actions: [
                                Button(
                                    type: ButtonTypes.rounded,
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await IsarDatabase.isar.writeTxn(() =>
                                          IsarDatabase.isar.pixKeys
                                              .delete(pixKey.id));
                                    },
                                    label: 'Excluir'),
                                Button(
                                    type: ButtonTypes.transparent,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    label: 'Cancelar'),
                              ],
                              content: Text(
                                'Tem certeza que deseja excluir esta chave?',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.zero,
                        child: const ActionItem(
                            label: 'Excluir',
                            iconAssetName: 'assets/images/trash.svg')),
                  ],
                  child: Container(
                    padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
                    child: AppIcon(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      assetName: 'assets/images/three-dots.svg',
                      height: 4,
                    ),
                  ),
                ),
              if (allowActions)
                const SizedBox(
                  height: 8,
                ),
              Text(
                keyTypeLabel.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ],
          )
        ],
      ),
    );
  }
}
