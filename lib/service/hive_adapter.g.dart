// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatContentAdapter extends TypeAdapter<ChatContent> {
  @override
  final int typeId = 0;

  @override
  ChatContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatContent(
      sender: fields[1] as Sender,
      message: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatContent obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.sender)
      ..writeByte(2)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SenderAdapter extends TypeAdapter<Sender> {
  @override
  final int typeId = 1;

  @override
  Sender read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Sender.user;
      case 1:
        return Sender.gemini;
      default:
        return Sender.user;
    }
  }

  @override
  void write(BinaryWriter writer, Sender obj) {
    switch (obj) {
      case Sender.user:
        writer.writeByte(0);
        break;
      case Sender.gemini:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SenderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
