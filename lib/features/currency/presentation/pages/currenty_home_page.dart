import 'package:currency_converter/core/resources/all_resources.dart';
import 'package:currency_converter/features/currency/presentation/bloc/currency_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyHomePage extends StatelessWidget {
  const CurrencyHomePage({
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
                color: ColorManager.accent,
              ),
            );
          }
          if (state is CurrencyLoaded) {
            return ListView.builder(
              itemCount: state.currenyData.symbols?.length ?? 2,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      state.currenyData.symbols?[index].currencyCode ?? ''),
                  subtitle: Text(
                    state.currenyData.symbols?[index].currencyName ?? '',
                  ),
                );
              },
            );
          } else {
            //retry button
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (state as CurrencyError).message,
                    style: const TextStyle(color: ColorManager.error),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CurrencyBloc>(context)
                          .add(GetCurrencyListEvent());
                    },
                    child: const Text("Retry"),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
