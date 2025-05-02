import 'package:flutter_hung_chatbot/model/gemini_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gemini_request.g.dart';

@JsonSerializable()
class GeminiRequest {
  @JsonKey(name: "contents")
  final List<Content> contents;

  GeminiRequest({this.contents = const []});

  GeminiRequest copyWith({List<Content>? contents}) => GeminiRequest(contents: contents ?? this.contents);

  factory GeminiRequest.fromJson(Map<String, dynamic> json) => _$GeminiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GeminiRequestToJson(this);
}
