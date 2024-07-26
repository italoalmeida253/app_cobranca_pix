import 'package:app_cobranca_pix/providers/create_billing_provider.dart';
import 'package:app_cobranca_pix/screens/create_billing_screen.dart';
import 'package:app_cobranca_pix/widgets/button.dart';
import 'package:app_cobranca_pix/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class CreateBillingStep2 extends StatelessWidget {
  const CreateBillingStep2({super.key});

  @override
  Widget build(BuildContext context) {
    final createBillingProvider = context.read<CreateBillingProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Cobrança gerada',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                width: 200,
                height: 200,
                child: QrImageView(data: createBillingProvider.qrCode!),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                createBillingProvider.qrCode!,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ButtonIcon(
                        onTap: () {
                          Share.share(createBillingProvider.qrCode!);
                        },
                        label: 'Compartilhar',
                        iconAssetName: 'assets/images/share.svg'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: ButtonIcon(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: createBillingProvider.qrCode!));
                        },
                        label: 'Copiar código',
                        iconAssetName: 'assets/images/copy.svg'),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Button(
                label: 'Criar nova cobrança',
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) =>
                            const CreateBillingScreen(),
                      ));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
