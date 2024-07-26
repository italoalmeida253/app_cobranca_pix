import 'package:app_cobranca_pix/models/pix_key.dart';
import 'package:app_cobranca_pix/providers/add_key_provider.dart';
import 'package:app_cobranca_pix/widgets/add_key_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddKeyScreen extends StatefulWidget {
  final PixKey? editPixKey;

  const AddKeyScreen({super.key, this.editPixKey});

  @override
  State<AddKeyScreen> createState() => _AddKeyScreenState();
}

class _AddKeyScreenState extends State<AddKeyScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddKeyProvider(editPixKey: widget.editPixKey),
      child: const AddKeyStepper(),
    );
  }
}
