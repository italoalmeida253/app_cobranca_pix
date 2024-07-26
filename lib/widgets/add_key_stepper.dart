import 'package:app_cobranca_pix/providers/add_key_provider.dart';
import 'package:app_cobranca_pix/widgets/add_key_step_1.dart';
import 'package:app_cobranca_pix/widgets/add_key_step_2.dart';
import 'package:app_cobranca_pix/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddKeyStepper extends StatefulWidget {
  const AddKeyStepper({super.key});

  @override
  State<AddKeyStepper> createState() => _AddKeyStepperState();
}

class _AddKeyStepperState extends State<AddKeyStepper> {
  int step = 0;
  late List<Widget> steps = [const AddKeyStep1(), AddKeyStep2()];

  @override
  Widget build(BuildContext context) {
    final AddKeyProvider addKeyProvider = context.watch<AddKeyProvider>();

    if (addKeyProvider.selectedKey != null) {
      step = 1;
    }

    return AppContainer(child: steps[step]);
  }
}
