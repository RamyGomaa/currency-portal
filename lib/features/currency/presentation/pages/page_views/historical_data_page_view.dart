import 'package:currency_converter/core/resources/all_resources.dart';
import 'package:currency_converter/core/resources/styles_manager.dart';
import 'package:currency_converter/features/currency/presentation/bloc/currency_historical_data_bloc.dart';
import 'package:currency_converter/features/currency/presentation/pages/page_views/currency_convertion_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../domain/entities/currency_entity.dart';

class HistoricalDataPage extends StatefulWidget {
  const HistoricalDataPage({super.key, required this.currencyData});
  final CurrencyResponseEntity currencyData;

  @override
  _HistoricalDataPageState createState() => _HistoricalDataPageState();
}

class _HistoricalDataPageState extends State<HistoricalDataPage> {
  String? _selectedBaseCurrency;
  String? _selectedTargetCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: BlocBuilder<CurrencyHistoricalDataBloc,
                  CurrencyHistoricalDataState>(
                builder: (context, state) {
                  if (state is CurrencyHistoricalDataLoaded) {
                    return Builder(builder: (context) {
                      // Prepare the data for the chart
                      final List<ChartData> chartData = [];

                      state.historicalData.rates!.forEach((date, elements) {
                        elements.forEach((currency, rate) {
                          chartData.add(ChartData(
                            date: date,
                            currency: currency,
                            rate: rate,
                          ));
                        });
                      });
                      return Column(
                        children: [
                          // Text('Historical Data',
                          //     style: TextStyle(fontSize: 20.sp)),
                          // Text('Base: ${state.historicalData.base}',
                          //     style: TextStyle(fontSize: 16.sp)),
                          // Text('Start Date: ${state.historicalData.startDate}',
                          //     style: TextStyle(fontSize: 16.sp)),
                          // Text('End Date: ${state.historicalData.endDate}',
                          //     style: TextStyle(fontSize: 16.sp)),
                          // Text('Success: ${state.historicalData.success}',
                          //     style: TextStyle(fontSize: 16.sp)),
                          // Text('Rates:', style: TextStyle(fontSize: 16.sp)),
                          // ...state.historicalData.rates!.entries.map((e) =>
                          //     Text('${e.key}: ${e.value}',
                          //         style: TextStyle(fontSize: 16.sp))),
                          Expanded(
                            child: SfCartesianChart(
                              primaryXAxis: const CategoryAxis(),
                              title: const ChartTitle(
                                  text: 'Historical Currency Rates'),
                              legend: const Legend(isVisible: true),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <CartesianSeries<ChartData, String>>[
                                LineSeries<ChartData, String>(
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) =>
                                      data.formatedDate,
                                  yValueMapper: (ChartData data, _) =>
                                      data.rate,
                                  name: chartData.first.currency,
                                  dataLabelSettings:
                                      const DataLabelSettings(isVisible: true),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
                  } else if (state is CurrencyHistoricalDataError) {
                    return Text(
                      AppStrings.errorGettingDataPageState,
                      style: getLightTextStyle(),
                      textAlign: TextAlign.center,
                    );
                  } else if (state is CurrencyHistoricalDataInitial) {
                    return const Text('No Data');
                  } else {
                    return const CircularProgressIndicator(
                      color: ColorManager.grey,
                    );
                  }
                },
              ),
            ),
          ),
          DefaultDropDownList(
            value: _selectedBaseCurrency,
            label: 'Select Base Currency',
            onChanged: (String? newValue) {
              setState(() {
                _selectedBaseCurrency = newValue;
              });
            },
            items: widget.currencyData.symbols!,
          ),
          SizedBox(height: 16.h),
          DefaultDropDownList(
            value: _selectedTargetCurrency,
            label: 'Select Target Currency',
            onChanged: (String? newValue) {
              setState(() {
                _selectedTargetCurrency = newValue;
              });
            },
            items: widget.currencyData.symbols!,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (_selectedBaseCurrency != null &&
                  _selectedTargetCurrency != null) {
                BlocProvider.of<CurrencyHistoricalDataBloc>(context)
                    .add(GetHistoricalDataEvent(
                  targetCurrency: _selectedTargetCurrency!,
                  base: _selectedBaseCurrency!,
                ));
              } else {
                // Show error message
                //remove the snackbar
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    //with ok button
                    content: const Text(
                        'Please select both base and target currency'),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      },
                    ),
                  ),
                );
              }
            },
            child: Text('Compare'),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String date;
  final String currency;
  final double rate;

  //return date with the format like this 'MM-dd' using intl package
  get formatedDate => DateFormat('MM-dd').format(DateTime.parse(date));

  ChartData({required this.date, required this.currency, required this.rate});
}
