import 'package:app_cobranca_pix/providers/create_billing_provider.dart';
import 'package:app_cobranca_pix/widgets/create_billing_step_1.dart';
import 'package:app_cobranca_pix/widgets/create_billing_step_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBillingStepper extends StatefulWidget {
  const CreateBillingStepper({super.key});

  @override
  State<CreateBillingStepper> createState() => _CreateBillingStepperState();
}

class _CreateBillingStepperState extends State<CreateBillingStepper> {
  int step = 0;
  List<Widget> steps = const [
    CreateBillingStep1(),
    CreateBillingStep2(),
  ];

  @override
  Widget build(BuildContext context) {
    final createBillingProvider = context.watch<CreateBillingProvider>();

    if (createBillingProvider.qrCode != null) {
      step = 1;
    }

    return steps[step];
  }
}
