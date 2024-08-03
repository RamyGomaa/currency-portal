import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/currency_entity.dart';
import '../currency_bloc/currency_bloc.dart';

class CurrencyFlag extends StatelessWidget {
  const CurrencyFlag({
    super.key,
    required this.symbol,
  });

  final CurrencyResponseDataEntity? symbol;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrencyBloc>(
      create: (context) => sl<CurrencyBloc>(),
      child: Builder(builder: (context) {
        return Material(
          color: ColorManager.lightGrey,
          child: CachedNetworkImage(
              imageUrl: '',
              placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.accent,
                    ),
                  ),
              errorWidget: (context, url, error) => FutureBuilder<File>(
                    future: BlocProvider.of<CurrencyBloc>(context)
                        .loadBase64Image(symbol?.base64Image ?? '',
                            symbol?.currencyCode ?? ''),
                    builder:
                        (BuildContext context, AsyncSnapshot<File> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Image.file(snapshot.data!);
                        } else {
                          return FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                border: Border.all(
                                  width: 0.1,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )),
        );
      }),
    );
  }
}
