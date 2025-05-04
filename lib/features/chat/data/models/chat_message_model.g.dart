// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageModelAdapter extends TypeAdapter<ChatMessageModel> {
  @override
  final int typeId = 0;

  @override
  ChatMessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessageModel(
      sender: fields[0] as SenderType,
      message: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessageModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sender)
      ..writeByte(1)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SenderTypeAdapter extends TypeAdapter<SenderType> {
  @override
  final int typeId = 1;

  @override
  SenderType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SenderType.user;
      case 1:
        return SenderType.gemini;
      default:
        return SenderType.user;
    }
  }

  @override
  void write(BinaryWriter writer, SenderType obj) {
    switch (obj) {
      case SenderType.user:
        writer.writeByte(0);
        break;
      case SenderType.gemini:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SenderTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
