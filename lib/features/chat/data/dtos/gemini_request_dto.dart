import 'package:flutter_hung_chatbot/features/chat/data/dtos/gemini_base_dto.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/gemini/gemini_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gemini_request_dto.g.dart';

@JsonSerializable()
class GeminiRequestDto {
  @JsonKey(name: "contents")
  final List<ContentDto> contents;

  GeminiRequestDto({this.contents = const []});

  GeminiRequestDto copyWith({List<ContentDto>? contents}) => GeminiRequestDto(contents: contents ?? this.contents);

  factory GeminiRequestDto.fromJson(Map<String, dynamic> json) => _$GeminiRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GeminiRequestDtoToJson(this);

  GeminiRequest toEntity() {
    return GeminiRequest(contents: contents.map((content) => content.toEntity()).toList());
  }

  static GeminiRequestDto fromEntity(GeminiRequest geminiRequest) {
    return GeminiRequestDto(contents: geminiRequest.contents.map((content) => ContentDto.fromEntity(content)).toList());
  }
}
