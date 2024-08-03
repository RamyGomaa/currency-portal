import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/all_resources.dart';
import '../../domain/entities/currency_entity.dart';
import '../currency_bloc/currency_bloc.dart';
import 'currency_flag_widget.dart';

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
        height: 40.h,
        width: 40.w,
        child: CurrencyFlag(symbol: symbol),
      ),
      subtitle: Text(
        symbol?.currencyName ?? '',
      ),
    );
  }
}
