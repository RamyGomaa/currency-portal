import 'package:flutter/material.dart';

import '../../../../../core/resources/all_resources.dart';
import '../../../domain/entities/currency_entity.dart';

class HistoricalDataPage extends StatelessWidget {
  const HistoricalDataPage({super.key, required this.currencyData});
  final CurrencyResponseEntity currencyData;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Historical Data Page",
        style: getRegularTextStyle(
          color: ColorManager.textPrimary,
          fontSize: 18,
        ),
      ),
    );
  }
}
