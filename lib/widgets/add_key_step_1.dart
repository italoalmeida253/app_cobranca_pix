import 'package:app_cobranca_pix/constants/index.dart';
import 'package:app_cobranca_pix/providers/add_key_provider.dart';
import 'package:app_cobranca_pix/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddKeyStep1 extends StatelessWidget {
  const AddKeyStep1({super.key});

  @override
  Widget build(BuildContext context) {
    final addKeyProvider = context.read<AddKeyProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      child: Column(
        children: [
          Text(
            'Qual tipo de chave você deseja cadastrar?',
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ,
          ),
          const SizedBox(
            height: 32,
          ),
          Button(
              onTap: () => addKeyProvider.selectKeyType(PixKeyTypes.phone),
              label: 'Celular'),
          const SizedBox(
            height: 12,
          ),
          Button(
              onTap: () => addKeyProvider.selectKeyType(PixKeyTypes.email),
              label: 'E-mail'),
          const SizedBox(
            height: 12,
          ),
          Button(
              onTap: () => addKeyProvider.selectKeyType(PixKeyTypes.cpf),
              label: 'CPF'),
          const SizedBox(
            height: 12,
          ),
          Button(
              onTap: () => addKeyProvider.selectKeyType(PixKeyTypes.cnpj),
              label: 'CNPJ'),
          const SizedBox(
            height: 12,
          ),
          Button(
              onTap: () => addKeyProvider.selectKeyType(PixKeyTypes.randomKey),
              label: 'Chave aleatória')
        ],
      ),
    );
  }
}
