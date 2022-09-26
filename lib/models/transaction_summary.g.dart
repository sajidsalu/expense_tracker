// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_summary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionSummaryAdapter extends TypeAdapter<TransactionSummary> {
  @override
  final int typeId = 3;

  @override
  TransactionSummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionSummary(
      expense: fields[0] as double,
      income: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionSummary obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.expense)
      ..writeByte(1)
      ..write(obj.income);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionSummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
