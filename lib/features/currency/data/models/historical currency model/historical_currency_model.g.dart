// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_currency_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoricalCurrencyResponseModelAdapter
    extends TypeAdapter<HistoricalCurrencyResponseModel> {
  @override
  final int typeId = 6;

  @override
  HistoricalCurrencyResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoricalCurrencyResponseModel(
      success: fields[0] as bool,
      base: fields[1] as String,
      startDate: fields[2] as String,
      endDate: fields[3] as String,
      rates: (fields[4] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as Map).cast<String, double>())),
    );
  }

  @override
  void write(BinaryWriter writer, HistoricalCurrencyResponseModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.base)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.rates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoricalCurrencyResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoricalCurrencyResponseModel _$HistoricalCurrencyResponseModelFromJson(
        Map<String, dynamic> json) =>
    HistoricalCurrencyResponseModel(
      success: json['success'] as bool,
      base: json['base'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      rates: (json['rates'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            )),
      ),
    );

Map<String, dynamic> _$HistoricalCurrencyResponseModelToJson(
        HistoricalCurrencyResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'base': instance.base,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'rates': instance.rates,
    };
