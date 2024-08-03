// Mocks generated by Mockito 5.4.4 from annotations
// in currency_converter/test/features/currency/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:currency_converter/core/flavor/flavor_config.dart' as _i11;
import 'package:currency_converter/core/network/network_info.dart' as _i10;
import 'package:currency_converter/features/currency/data/datasources/currency_local_datasource.dart'
    as _i9;
import 'package:currency_converter/features/currency/data/datasources/currency_remote_datasource.dart'
    as _i5;
import 'package:currency_converter/features/currency/domain/entities/currency_entity.dart'
    as _i3;
import 'package:currency_converter/features/currency/domain/entities/currrency_convert_entity.dart'
    as _i2;
import 'package:currency_converter/features/currency/domain/entities/historical_currency_entity.dart'
    as _i4;
import 'package:currency_converter/features/currency/domain/params/convert_currency_params.dart'
    as _i7;
import 'package:currency_converter/features/currency/domain/params/historical_currency_params.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i12;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCurrencyConvertResponseEntity_0 extends _i1.SmartFake
    implements _i2.CurrencyConvertResponseEntity {
  _FakeCurrencyConvertResponseEntity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCurrencyResponseEntity_1 extends _i1.SmartFake
    implements _i3.CurrencyResponseEntity {
  _FakeCurrencyResponseEntity_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHistoricalCurrencyResponseEntity_2 extends _i1.SmartFake
    implements _i4.HistoricalCurrencyResponseEntity {
  _FakeHistoricalCurrencyResponseEntity_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CurrencyRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCurrencyRemoteDataSource extends _i1.Mock
    implements _i5.CurrencyRemoteDataSource {
  MockCurrencyRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.CurrencyConvertResponseEntity> convertCurrency(
          _i7.ConvertCurrencyParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertCurrency,
          [params],
        ),
        returnValue: _i6.Future<_i2.CurrencyConvertResponseEntity>.value(
            _FakeCurrencyConvertResponseEntity_0(
          this,
          Invocation.method(
            #convertCurrency,
            [params],
          ),
        )),
      ) as _i6.Future<_i2.CurrencyConvertResponseEntity>);

  @override
  _i6.Future<_i3.CurrencyResponseEntity> getCurrencyList(String? apiKey) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrencyList,
          [apiKey],
        ),
        returnValue: _i6.Future<_i3.CurrencyResponseEntity>.value(
            _FakeCurrencyResponseEntity_1(
          this,
          Invocation.method(
            #getCurrencyList,
            [apiKey],
          ),
        )),
      ) as _i6.Future<_i3.CurrencyResponseEntity>);

  @override
  _i6.Future<_i4.HistoricalCurrencyResponseEntity> getHistoricalData(
          _i8.HistoricalCurrencyParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHistoricalData,
          [params],
        ),
        returnValue: _i6.Future<_i4.HistoricalCurrencyResponseEntity>.value(
            _FakeHistoricalCurrencyResponseEntity_2(
          this,
          Invocation.method(
            #getHistoricalData,
            [params],
          ),
        )),
      ) as _i6.Future<_i4.HistoricalCurrencyResponseEntity>);
}

/// A class which mocks [CurrencyLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockCurrencyLocalDataSource extends _i1.Mock
    implements _i9.CurrencyLocalDataSource {
  MockCurrencyLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<void> cacheCurrencyList(
          _i3.CurrencyResponseEntity? currencyList) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheCurrencyList,
          [currencyList],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i4.HistoricalCurrencyResponseEntity>? getHistoricalData(
          _i8.HistoricalCurrencyParams? params) =>
      (super.noSuchMethod(Invocation.method(
        #getHistoricalData,
        [params],
      )) as _i6.Future<_i4.HistoricalCurrencyResponseEntity>?);

  @override
  _i6.Future<void> cacheHistoricalData(
          _i4.HistoricalCurrencyResponseEntity?
              historicalCurrencyResponseEntity) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheHistoricalData,
          [historicalCurrencyResponseEntity],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i2.CurrencyConvertResponseEntity>? getConvertCurrency(
          _i7.ConvertCurrencyParams? params) =>
      (super.noSuchMethod(Invocation.method(
        #getConvertCurrency,
        [params],
      )) as _i6.Future<_i2.CurrencyConvertResponseEntity>?);

  @override
  _i6.Future<void> cacheCurrencyConversion(
          _i2.CurrencyConvertResponseEntity? currencyConvertResponseEntity) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheCurrencyConversion,
          [currencyConvertResponseEntity],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i10.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> get isConnectedToServer => (super.noSuchMethod(
        Invocation.getter(#isConnectedToServer),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}

/// A class which mocks [FlavorConfig].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlavorConfig extends _i1.Mock implements _i11.FlavorConfig {
  MockFlavorConfig() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Flavor get flavor => (super.noSuchMethod(
        Invocation.getter(#flavor),
        returnValue: _i11.Flavor.prod,
      ) as _i11.Flavor);

  @override
  String get currencyBaseUrl => (super.noSuchMethod(
        Invocation.getter(#currencyBaseUrl),
        returnValue: _i12.dummyValue<String>(
          this,
          Invocation.getter(#currencyBaseUrl),
        ),
      ) as String);

  @override
  String get currencyApiKey => (super.noSuchMethod(
        Invocation.getter(#currencyApiKey),
        returnValue: _i12.dummyValue<String>(
          this,
          Invocation.getter(#currencyApiKey),
        ),
      ) as String);

  @override
  bool get isDev => (super.noSuchMethod(
        Invocation.getter(#isDev),
        returnValue: false,
      ) as bool);

  @override
  bool get isProd => (super.noSuchMethod(
        Invocation.getter(#isProd),
        returnValue: false,
      ) as bool);
}