import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:app_cobranca_pix/services/isar.dart';
import 'package:app_cobranca_pix/widgets/add_key_button.dart';
import 'package:app_cobranca_pix/widgets/app_container.dart';
import 'package:app_cobranca_pix/widgets/app_icon.dart';
import 'package:app_cobranca_pix/widgets/app_input.dart';
import 'package:app_cobranca_pix/widgets/key_card.dart';
import 'package:app_cobranca_pix/widgets/no_content_warn.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController(text: '');
  String search = '';

  @override
  Widget build(BuildContext context) {
    IsarDatabase.isar.pixKeys.watchLazy();

    return AppContainer(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bem vindo!',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.merge(const TextStyle(color: Colors.black)),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Organize suas chaves e crie cobranças de forma rápida e eficiente.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.merge(const TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Chaves recentes',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const AppIcon(
                          assetName: 'assets/images/clock.svg',
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
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
                            separatorBuilder: (context, index) =>
                                const SizedBox(
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
        )
      ],
    ));
  }
}
