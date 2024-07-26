import 'package:app_cobranca_pix/constants/index.dart';
import 'package:flutter/material.dart';

class CurrencyInput extends StatefulWidget {
  final Function(double value)? onChanged;

  const CurrencyInput({super.key, this.onChanged});

  @override
  State<CurrencyInput> createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {
  late TextEditingController controller;
  int changes = 0;

  @override
  void initState() {
    controller = TextEditingController(text: brlFormatter.format(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(.36))),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(.36))),
      ),
      style: Theme.of(context)
          .textTheme
          .displayMedium
          ?.merge(TextStyle(color: Theme.of(context).colorScheme.primary)),
      onChanged: (value) {
        if (value.isEmpty) {
          controller.text = brlFormatter.format(0);
          return;
        }
        String currentValue = controller.text;

        currentValue = currentValue.replaceAll(RegExp(r'[^0-9]'), '');
        bool addZero = false;

        final int commaIndex = currentValue.length - 2;

        if (currentValue.substring(0, commaIndex).isEmpty) {
          addZero = true;
        }

        currentValue =
            '${addZero ? '0' : currentValue.substring(0, commaIndex)}.${currentValue.substring(commaIndex)}';

        controller.text = brlFormatter.format(double.parse(currentValue));
        if (widget.onChanged != null) {
          final numberValue =
              currentValue
              .replaceAll('R\$', '')
              .replaceAll(',', '.');
          widget.onChanged!(double.parse(numberValue));
        }
      },
    );
  }
}
