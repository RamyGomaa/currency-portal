import 'package:currency_converter/core/resources/all_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../currency_bloc/currency_bloc.dart';

class ErrorGettingCurrencyDataPageState extends StatelessWidget {
  const ErrorGettingCurrencyDataPageState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: ColorManager.secondary,
              size: 80,
            ),
            const SizedBox(height: 16),
            Text(
              "Oops! Something went wrong.",
              style: getSemiBoldTextStyle(
                color: ColorManager.secondary,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "We couldn't fetch the currency data. Please check your connection or try again later.",
              style: getRegularTextStyle(
                color: ColorManager.secondary,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                BlocProvider.of<CurrencyBloc>(context)
                    .add(GetCurrencyListEvent());
              },
              icon: const Icon(Icons.refresh, color: ColorManager.white),
              label: Text(
                "Retry",
                style: getLightTextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: getSemiBoldTextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
