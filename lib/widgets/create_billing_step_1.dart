import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:app_cobranca_pix/providers/create_billing_provider.dart';
import 'package:app_cobranca_pix/screens/home_screen.dart';
import 'package:app_cobranca_pix/services/isar.dart';
import 'package:app_cobranca_pix/theme/colors.dart';
import 'package:app_cobranca_pix/widgets/app_dropdown.dart';
import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:app_cobranca_pix/widgets/button.dart';
import 'package:app_cobranca_pix/widgets/currency_input.dart';
import 'package:app_cobranca_pix/widgets/key_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class CreateBillingStep1 extends StatelessWidget {
  const CreateBillingStep1({super.key});

  @override
  Widget build(BuildContext context) {
    final createBillingProvider = context.watch<CreateBillingProvider>();

    return Padding(
      padding: const EdgeInsets.only(top: 48, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Crie um QR Code para receber pagamentos',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Ao criar uma cobrança sem um valor definido, o cliente que escanear o QR Code poderá inserir o valor que desejar.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Valor a receber',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    CurrencyInput(
                      onChanged: (value) {
                        createBillingProvider.changeValue(value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              AppDropdown(
                  triggerChild: Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.white.withOpacity(.36)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (createBillingProvider.selectedKey != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(26),
                                  child: Image.asset(
                                    createBillingProvider.selectedKey!.bankLogo,
                                    height: 26,
                                  ),
                                )
                              else
                                AppIcon(
                                  assetName: 'assets/images/key.svg',
                                  height: 26,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                createBillingProvider.selectedKey != null
                                    ? createBillingProvider
                                        .selectedKey!.bankName
                                    : 'Chave para recebimento',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.merge(TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          if (createBillingProvider.selectedKey != null)
                            Expanded(
                              child: Text(
                                createBillingProvider.selectedKey!.value,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  child: FutureBuilder(
                    future: IsarDatabase.isar.pixKeys.where().findAll(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }
                      if (snapshot.data!.isNotEmpty) {
                        return ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 150),
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: snapshot.data!.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 12,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                createBillingProvider
                                    .selectKey(snapshot.data![index]);
                              },
                              child: KeyCard(
                                pixKey: snapshot.data![index],
                              ),
                            ),
                          ),
                        );
                      }
                      if (snapshot.data!.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Nenhuma chave cadastrada.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Nenhuma chave cadastrada.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    },
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Opacity(
                  opacity: createBillingProvider.selectedKey != null ? 1 : .5,
                  child: Button(
                    onTap: () {
                      if (createBillingProvider.selectedKey != null) {
                        createBillingProvider.createBilling();
                      }
                    },
                    label: 'Salvar',
                    type: ButtonTypes.rounded,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Button(
                  onTap: () {
                    Navigator.pop(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context, _, __) => const HomeScreen(),
                            transitionDuration: Duration.zero));
                  },
                  label: 'Cancelar',
                  type: ButtonTypes.transparent,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
