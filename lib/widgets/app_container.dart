import 'package:app_cobranca_pix/widgets/navbar.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;

  const AppContainer(
      {super.key, this.backgroundColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: child),
          const Navbar()
        ],
      )),
    );
  }
}
