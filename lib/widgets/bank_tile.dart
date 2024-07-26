import 'package:flutter/material.dart';

class BankTile extends StatelessWidget {
  final String bankName;

  const BankTile({super.key, required this.bankName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/bradesco-logo.png'),
              const SizedBox(
                width: 12,
              ),
              Text(
                bankName,
                style: Theme.of(context).textTheme.displaySmall?.merge(
                  TextStyle(color: Theme.of(context).colorScheme.inverseSurface)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
