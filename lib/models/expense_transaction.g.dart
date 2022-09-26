// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseTransactionAdapter extends TypeAdapter<ExpenseTransaction> {
  @override
  final int typeId = 0;

  @override
  ExpenseTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseTransaction(
      category: fields[0] as String,
      categoryId: fields[6] as int,
      description: fields[1] as String,
      date: fields[2] as String,
      amount: fields[3] as double,
      type: fields[4] as String,
      id: fields[5] as String,
      isExpense: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseTransaction obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.categoryId)
      ..writeByte(7)
      ..write(obj.isExpense);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
