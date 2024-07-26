import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:app_cobranca_pix/providers/create_billing_provider.dart';
import 'package:app_cobranca_pix/widgets/app_container.dart';
import 'package:app_cobranca_pix/widgets/create_billing_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBillingScreen extends StatelessWidget {
  final PixKey? pixKey;

  const CreateBillingScreen({super.key, this.pixKey});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateBillingProvider(selectedKey: pixKey),
      child: const AppContainer(child: CreateBillingStepper()),
    );
  }
}
