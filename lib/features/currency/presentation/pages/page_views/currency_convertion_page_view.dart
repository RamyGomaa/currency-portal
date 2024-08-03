import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/all_resources.dart';
import '../../../domain/entities/currency_entity.dart';
import '../../currency_convertion_bloc/currency_conversion_bloc.dart';
import '../../widgets/currency_flag_widget.dart';

class CurrencyConversionPage extends StatefulWidget {
  final CurrencyResponseEntity currencyData;

  const CurrencyConversionPage({Key? key, required this.currencyData})
      : super(key: key);

  @override
  _CurrencyConversionPageState createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  String? _fromCurrency;
  String? _toCurrency;
  double? _amount;
  double? _result;

  void _convertCurrency() {
    if (_fromCurrency != null && _toCurrency != null && _amount != null) {
      // Perform the conversion logic here
      // For demonstration purposes, let's assume a fixed conversion rate
      double conversionRate = 48.0; // Example conversion rate
      setState(() {
        _result = _amount! * conversionRate;
      });

      BlocProvider.of<CurrencyConversionBloc>(context).add(
        ConvertCurrencyEvent(
          amount: _amount!,
          fromCurrency: _fromCurrency!,
          toCurrency: _toCurrency!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Stack(
              fit: StackFit.loose,
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DefaultDropDownList(
                          value: _fromCurrency,
                          label: 'From Currency',
                          items: widget.currencyData.symbols,
                          onChanged: (value) {
                            setState(() {
                              _fromCurrency = value;
                            });
                          }),
                      const SizedBox(height: 16),
                      DefaultDropDownList(
                          value: _toCurrency,
                          label: 'To Currency',
                          items: widget.currencyData.symbols,
                          onChanged: (value) {
                            setState(() {
                              _toCurrency = value;
                            });
                          }),
                    ],
                  ),
                ),
                Positioned(
                  top: 50.h,
                  right: 1.w,
                  child: ElevatedButton(
                    onPressed: _switchCurrencies,
                    //circular
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.swap_horiz,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: 16),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Amount",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _amount = double.tryParse(value);
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _convertCurrency,
            child: Text("Calculate",
                style: getLightTextStyle(color: ColorManager.white)),
          ),
          const SizedBox(height: 16),
          if (_result != null)
            BlocBuilder<CurrencyConversionBloc, CurrencyConversionState>(
              builder: (context, state) {
                if (state is CurrencyConversionLoaded) {
                  return Center(
                    child: Text(
                      "${state.result.query?.amount}  ${state.result.query?.from} = ${state.result.result}  ${state.result.query?.to}",
                      style: getLightTextStyle(
                        color: ColorManager.darkGrey,
                        fontSize: 20.sp,
                      ),
                    ),
                  );
                } else if (state is CurrencyConversionError) {
                  return Center(
                    child: Text(
                      "Error: ${state.message}",
                      style: getLightTextStyle(color: ColorManager.darkGrey),
                    ),
                  );
                } else {
                  //loading
                  return const Center(
                      child: CircularProgressIndicator(
                    color: ColorManager.grey,
                  ));
                }
              },
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _switchCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _result = null;
    });
  }
}

class DefaultDropDownList extends StatelessWidget {
  const DefaultDropDownList(
      {super.key,
      required this.value,
      required this.label,
      required this.onChanged,
      this.items});
  final String? value;
  final String label;
  final Function(String?) onChanged;
  final List<CurrencyResponseDataEntity>? items;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      dropdownColor: ColorManager.white,
      hint: Text(label),
      items: items?.map((symbol) {
        return DropdownMenuItem<String>(
          value: symbol.currencyCode,
          child: dropdownMenuItem(symbol),
        );
      }).toList(),
      onChanged: (value) {
        onChanged(value);
      },
    );
  }

  Row dropdownMenuItem(CurrencyResponseDataEntity symbol) {
    return Row(
      children: [
        SizedBox(
          height: 30.h,
          width: 30.w,
          child: CurrencyFlag(symbol: symbol),
        ),
        const SizedBox(width: 8),
        Text(symbol.currencyCode ?? ''),
      ],
    );
  }
}
