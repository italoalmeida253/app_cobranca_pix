import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:app_cobranca_pix/providers/create_billing_provider.dart';
import 'package:app_cobranca_pix/services/isar.dart';
import 'package:app_cobranca_pix/widgets/add_key_button.dart';
import 'package:app_cobranca_pix/widgets/key_card.dart';
import 'package:app_cobranca_pix/widgets/no_content_warn.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class BillingsScreen extends StatelessWidget {
  const BillingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final createBillingProvider = context.read<CreateBillingProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cobranças',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
                    return ListView.separated(
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          createBillingProvider.selectKey(snapshot.data![index]);
                        },
                        child: KeyCard(
                          pixKey: snapshot.data![index],
                          allowActions: false,
                        ),
                      ),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: NoContentWarn(
                          iconAssetName: 'assets/images/key.svg',
                          warn:
                              'Nenhuma chave PIX cadastrada. Clique no botão abaixo para adicionar sua primeira chave.'),
                    );
                  }
                  return const Center(
                    child: NoContentWarn(
                        iconAssetName: 'assets/images/key.svg',
                        warn: 'Erro ao carregar suas chaves. Tente novamente.'),
                  );
                },
              ),
            ),
          ),
          const AddKeyButton()
        ],
      ),
    );
  }
}
