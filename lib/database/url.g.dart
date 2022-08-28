// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UrlAdapter extends TypeAdapter<Url> {
  @override
  final int typeId = 1;

  @override
  Url read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Url(
      url: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Url obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
