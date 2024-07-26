import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:app_cobranca_pix/services/isar.dart';
import 'package:app_cobranca_pix/widgets/add_key_button.dart';
import 'package:app_cobranca_pix/widgets/app_container.dart';
import 'package:app_cobranca_pix/widgets/app_input.dart';
import 'package:app_cobranca_pix/widgets/key_card.dart';
import 'package:app_cobranca_pix/widgets/no_content_warn.dart';
import 'package:flutter/material.dart';

class KeysScreen extends StatefulWidget {
  const KeysScreen({super.key});

  @override
  State<KeysScreen> createState() => _KeysScreenState();
}

class _KeysScreenState extends State<KeysScreen> {
  final searchController = TextEditingController(text: '');
  String search = '';

  @override
  Widget build(BuildContext context) {
    IsarDatabase.isar.pixKeys.watchLazy();

    return AppContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppInput(
              controller: searchController,
              hintText: 'Pesquisar por chaves',
              iconAssetName: 'assets/images/magnifier.svg',
              onChanged: (value) {
                searchController.text = value;
                setState(() {
                  search = value;
                });
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: StreamBuilder(
                  stream: IsarDatabase.listenPixKeys(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    }
                    if (snapshot.data!.isNotEmpty) {
                      List<PixKey> filteredKeys = [];
                      if (search.isNotEmpty) {
                        snapshot.data?.forEach((pixKey) {
                          if (pixKey.description
                              .toLowerCase()
                              .contains(search.toString())) {
                            filteredKeys.add(pixKey);
                          }
                        });
                      }
            
                      return ListView.separated(
                        itemCount: search.isNotEmpty
                            ? filteredKeys.length
                            : snapshot.data!.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                        itemBuilder: (context, index) => KeyCard(
                          pixKey: search.isNotEmpty
                              ? filteredKeys[index]
                              : snapshot.data![index],
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
                          warn:
                              'Erro ao carregar suas chaves. Tente novamente.'),
                    );
                  },
                ),
              ),
            ),
            const AddKeyButton()
          ],
        ),
      ),
    );
  }
}
