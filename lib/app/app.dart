import 'package:currency_converter/core/resources/all_resources.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(context),
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
