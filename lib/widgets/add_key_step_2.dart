import 'package:app_cobranca_pix/constants/index.dart';
import 'package:app_cobranca_pix/providers/add_key_provider.dart';
import 'package:app_cobranca_pix/screens/home_screen.dart';
import 'package:app_cobranca_pix/widgets/app_dropdown.dart';
import 'package:app_cobranca_pix/widgets/app_input.dart';
import 'package:app_cobranca_pix/widgets/bank_tile.dart';
import 'package:app_cobranca_pix/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddKeyStep2 extends StatelessWidget {
  final keyValueController = TextEditingController(text: '');
  final keyDescriptionController = TextEditingController(text: '');

  AddKeyStep2({super.key});

  @override
  Widget build(BuildContext context) {
    final addKeyProvider = context.watch<AddKeyProvider>();

    if (addKeyProvider.editPixKey != null) {
      if (keyValueController.text.isEmpty) {
        keyValueController.text = addKeyProvider.editPixKey!.value;
      }
      if (keyDescriptionController.text.isEmpty) {
        keyDescriptionController.text = addKeyProvider.editPixKey!.description;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                addKeyProvider.label,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 16,
              ),
              AppInput(
                hintText: 'Digite sua chave aqui...',
                inputMask: addKeyProvider.inputMask,
                keyboardType: addKeyProvider.keyboardType,
                type: AppInputTypes.outline,
                controller: keyValueController,
                onChanged: (value) {
                  keyValueController.text = value;
                },
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Descrição',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 16,
              ),
              AppInput(
                hintText: 'Digite uma breve descrição...',
                controller: keyDescriptionController,
                type: AppInputTypes.outline,
                onChanged: (value) {
                  keyDescriptionController.text = value;
                },
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Instituição bancária',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 16,
              ),
              AppDropdown(
                iconAssetName: 'assets/images/chevron-down.svg',
                triggerChild: BankTile(
                  bank: addKeyProvider.bank,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 4,
                          ),
                      itemCount: banks.length,
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            addKeyProvider.selectBank(banks[index]);
                          },
                          child: BankTile(bank: banks[index]))),
                ),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Button(
                onTap: () async {
                  if (keyValueController.text.isEmpty ||
                      keyDescriptionController.text.isEmpty ||
                      addKeyProvider.bank == null) {
                    return;
                  }
                  Navigator.pop(context);
                  await addKeyProvider.saveKey(
                      keyValueController.text, keyDescriptionController.text);
                },
                label: 'Salvar',
                type: ButtonTypes.rounded,
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
        ],
      ),
    );
  }
}
