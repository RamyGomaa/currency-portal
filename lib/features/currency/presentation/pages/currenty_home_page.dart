import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter/core/resources/all_resources.dart';
import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart';
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
                var symbol = state.currenyData.symbols?[index];
                if (!symbol?.hasImageUrl) return const SizedBox();
                return CurrencyCard(symbol: symbol);
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

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    super.key,
    required this.symbol,
  });

  final CurrencyResponseDataEntity? symbol;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(symbol?.currencyCode ?? ''),
      leading: SizedBox(
        height: 40,
        width: 40,
        child: CachedNetworkImage(
            imageUrl: '',
            placeholder: (context, url) => const CircularProgressIndicator(
                  color: ColorManager.accent,
                ),
            errorWidget: (context, url, error) => Builder(builder: (context) {
                  final String? base64Image = symbol?.base64Image;
                  return FutureBuilder<File>(
                    future: BlocProvider.of<CurrencyBloc>(context)
                        .loadBase64Image(
                            base64Image ?? '', symbol?.currencyCode ?? ''),
                    builder:
                        (BuildContext context, AsyncSnapshot<File> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Image.file(snapshot.data!);
                        } else {
                          return const Icon(Icons.error);
                        }
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  );
                })),
      ),
      subtitle: Text(
        symbol?.currencyName ?? '',
      ),
    );
  }
}
