import 'package:currency_converter/core/constants/end_points.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

/// Import the flutter_dotenv package to use environment variables
/// Enum to represent the different flavors of the app
enum Flavor {
  prod,
  dev,
}

class FlavorConfig {
  /// The flavor of the app
  final Flavor flavor;
  final String currencyBaseUrl;
  final String currencyApiKey;

  /// A map of features that can be enabled or disabled

  /// A static instance of FlavorConfig that can be set and accessed
  static FlavorConfig? _instance;

  bool get isDev => flavor == Flavor.dev;
  bool get isProd => flavor == Flavor.prod;

  /// Private constructor for FlavorConfig
  FlavorConfig._internal({
    this.flavor = Flavor.prod,
    required this.currencyApiKey,
    required this.currencyBaseUrl,
  }) {
    //log flavor data
    Logger(output: ConsoleOutput()).i(
        'Flavor: $flavor | Currency Base URL: $currencyBaseUrl | Currency API Key: $currencyApiKey');
  }

  /// Static method to set the instance of FlavorConfig
  static void setInstance({required FlavorConfig instance}) {
    /// Ensure that the instance is not already set
    assert(_instance == null);
    _instance = instance;
  }

  /// Static method to configure the instance of FlavorConfig
  static void configure({
    Flavor? flavor,
    String? currencyBaseUrl,
    String? currencyApiKey,
  }) {
    _instance = FlavorConfig._internal(
      flavor: flavor ?? Flavor.prod,
      currencyBaseUrl: currencyBaseUrl ?? EndPoint.prodBaseUrl,
      currencyApiKey: currencyApiKey ?? dotenv.env['PROD_CURRENCY_API_KEY']!,
    );
  }

  /// Static getter to return the instance of FlavorConfig
  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception(
          "FlavorConfig must be configured before accessing instance");
    }
    return _instance!;
  }

  /// Static method to return the FlavorConfig instance corresponding to a given Flavor enum value
  static FlavorConfig getFlavorFromEnum(Flavor flavor) {
    switch (flavor) {
      case Flavor.prod:
        return prodFlavor;
      case Flavor.dev:
        return devFlavor;
      default:
        return prodFlavor;
    }
  }
}

/// Instance of FlavorConfig for the prod flavor
final FlavorConfig prodFlavor = FlavorConfig._internal(
  flavor: Flavor.prod,
  currencyBaseUrl: EndPoint.prodBaseUrl,
  currencyApiKey: dotenv.env['PROD_CURRENCY_API_KEY']!,
);

/// Instance of FlavorConfig for the dev flavor
final devFlavor = FlavorConfig._internal(
  flavor: Flavor.dev,
  currencyBaseUrl: EndPoint.devBaseUrl,
  currencyApiKey: dotenv.env['DEV_CURRENCY_API_KEY']!,
);
