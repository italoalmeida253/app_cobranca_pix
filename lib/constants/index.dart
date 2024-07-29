import 'package:app_cobranca_pix/models/bank.dart';
import 'package:intl/intl.dart';

const double navbarHeight = 68;

final List<Bank> banks = [
  Bank(name: 'Caixa', logoAssetName: 'assets/images/caixa.png'),
  Bank(name: 'Bradesco', logoAssetName: 'assets/images/bradesco.png'),
  Bank(name: 'Itaú', logoAssetName: 'assets/images/itau.png'),
  Bank(
      name: 'Banco do Brasil',
      logoAssetName: 'assets/images/banco-do-brasil.png'),
  Bank(name: 'Nubank', logoAssetName: 'assets/images/nubank.png'),
  Bank(name: 'Santander', logoAssetName: 'assets/images/santander.png'),
  Bank(name: 'Original', logoAssetName: 'assets/images/original.png'),
  Bank(name: 'Mercado Pago', logoAssetName: 'assets/images/mercado-pago.png'),
  Bank(name: 'PagBank', logoAssetName: 'assets/images/pagbank.png'),
  Bank(name: 'Inter', logoAssetName: 'assets/images/inter.png'),
  Bank(name: 'C6 Bank', logoAssetName: 'assets/images/c6-bank.png'),
  Bank(name: 'BTG Pactual', logoAssetName: 'assets/images/btg-pactual.png'),
  Bank(name: 'Neon', logoAssetName: 'assets/images/neon.png'),
  Bank(name: 'PicPay', logoAssetName: 'assets/images/picpay.png'),
  Bank(
      name: 'Banco do Nordeste',
      logoAssetName: 'assets/images/banco-do-nordeste.png'),
];

final brlFormatter =
    NumberFormat.currency(decimalDigits: 2, locale: 'pt-BR', symbol: 'R\$');

enum UserPrefs {
  pixKeys,
  darkModeKey,
}

enum PixKeyTypes {
  phone,
  email,
  cpf,
  cnpj,
  randomKey,
}
