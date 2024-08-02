import 'flavor_config.dart';

abstract class AppFeature {
  final List<Flavor> flavors;
  AppFeature({required this.flavors});
  bool isEnabled({Flavor? flavor}) {
    return flavors.contains(flavor ?? FlavorConfig.instance.flavor);
  }
}

class HistoricalDataAppFeature extends AppFeature {
  HistoricalDataAppFeature() : super(flavors: const [Flavor.dev, Flavor.prod]);
}

class CurrencyConverterAppFeature extends AppFeature {
  CurrencyConverterAppFeature()
      : super(flavors: const [Flavor.dev, Flavor.prod]);
}
