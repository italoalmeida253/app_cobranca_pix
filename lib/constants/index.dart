import 'package:intl/intl.dart';

const double navbarHeight = 68;

const List<String> banks = [
  'Bradesco',
  'Itaú',
  'Nubank',
  'Inter',
  'Banco do Brasil',
  'Caixa',
  'Banco PAN',
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
