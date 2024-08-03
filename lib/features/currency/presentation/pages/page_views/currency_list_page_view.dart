import 'package:flutter/material.dart';

import '../../../domain/entities/currency_entity.dart';
import '../../widgets/currency_card_widget.dart';

class CurrencyListPageView extends StatelessWidget {
  const CurrencyListPageView({super.key, required this.currencyData});
  final CurrencyResponseEntity currencyData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: currencyData.symbols?.length ?? 0,
      itemBuilder: (context, index) {
        var symbol = currencyData.symbols?[index];
        if (!symbol?.hasImageUrl) return const SizedBox();
        return CurrencyCard(symbol: symbol);
      },
    );
  }
}
