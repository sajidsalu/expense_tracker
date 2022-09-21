// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_categories.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionCategoriesAdapter extends TypeAdapter<TransactionCategories> {
  @override
  final int typeId = 1;

  @override
  TransactionCategories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionCategories(
      id: fields[0] as int,
      category: fields[1] as String,
      imagePath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionCategories obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionCategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
