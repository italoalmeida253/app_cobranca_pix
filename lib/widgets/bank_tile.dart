import 'package:app_cobranca_pix/models/bank.dart';
import 'package:flutter/material.dart';

class BankTile extends StatelessWidget {
  final Bank? bank;

  const BankTile({super.key, required this.bank});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (bank != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(38),
                  child: Image.asset(
                    bank!.logoAssetName,
                    height: 38,
                  ),
                ),
              if (bank != null)
                const SizedBox(
                  width: 12,
                ),
                if (bank == null) const SizedBox(height: 38,),
              Text(
                bank != null ? bank!.name : 'Selecione um banco',
                style: Theme.of(context).textTheme.displaySmall?.merge(
                    TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
