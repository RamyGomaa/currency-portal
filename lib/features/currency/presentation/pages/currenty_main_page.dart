import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter/core/resources/all_resources.dart';
import 'package:currency_converter/core/resources/styles_manager.dart';
import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/currency/presentation/bloc/currency_historical_data_bloc.dart';
import 'package:currency_converter/features/currency/presentation/currency_bloc/currency_bloc.dart';
import 'package:currency_converter/features/currency/presentation/currency_convertion_bloc/currency_conversion_bloc.dart';
import 'package:currency_converter/features/currency/presentation/pages/currency_home_page.dart';
import 'package:currency_converter/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states/error_getting_data_page_state.dart';

class CurrencyMainPage extends StatelessWidget {
  const CurrencyMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyInitial) {
            BlocProvider.of<CurrencyBloc>(context).add(GetCurrencyListEvent());
            return const Center(
              child: CircularProgressIndicator(
                color: ColorManager.accent,
              ),
            );
          }
          if (state is CurrencyLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorManager.grey,
              ),
            );
          }
          if (state is CurrencyLoaded) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<CurrencyBloc>(
                  create: (_) => sl<CurrencyBloc>(),
                ),
                BlocProvider<CurrencyConversionBloc>(
                  create: (context) => sl<CurrencyConversionBloc>(),
                ),
                BlocProvider<CurrencyHistoricalDataBloc>(
                  create: (context) => sl<CurrencyHistoricalDataBloc>(),
                ),
              ],
              child: HomePage(
                currencyData: state.currencyData,
              ),
            );
          } else {
            //retry button
            return const ErrorGettingCurrencyDataPageState();
          }
        },
      ),
    );
  }
}
