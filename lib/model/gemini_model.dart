import 'package:json_annotation/json_annotation.dart';

part 'gemini_model.g.dart';

@JsonSerializable()
class Candidate {
  @JsonKey(name: "content")
  final Content content;
  @JsonKey(name: "finishReason")
  final String finishReason;
  @JsonKey(name: "citationMetadata")
  final CitationMetadata citationMetadata;
  @JsonKey(name: "avgLogprobs")
  final double avgLogprobs;

  const Candidate({
    this.content = const Content(),
    this.finishReason = '',
    this.citationMetadata = const CitationMetadata(),
    this.avgLogprobs = 0,
  });

  Candidate copyWith({
    Content? content,
    String? finishReason,
    CitationMetadata? citationMetadata,
    double? avgLogprobs,
  }) => Candidate(
    content: content ?? this.content,
    finishReason: finishReason ?? this.finishReason,
    citationMetadata: citationMetadata ?? this.citationMetadata,
    avgLogprobs: avgLogprobs ?? this.avgLogprobs,
  );

  factory Candidate.fromJson(Map<String, dynamic> json) => _$CandidateFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateToJson(this);
}

@JsonSerializable()
class CitationMetadata {
  @JsonKey(name: "citationSources")
  final List<CitationSource> citationSources;

  const CitationMetadata({this.citationSources = const []});

  CitationMetadata copyWith({List<CitationSource>? citationSources}) =>
      CitationMetadata(citationSources: citationSources ?? this.citationSources);

  factory CitationMetadata.fromJson(Map<String, dynamic> json) => _$CitationMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CitationMetadataToJson(this);
}

@JsonSerializable()
class CitationSource {
  @JsonKey(name: "startIndex")
  final int startIndex;
  @JsonKey(name: "endIndex")
  final int endIndex;

  const CitationSource({this.startIndex = 0, this.endIndex = 0});

  CitationSource copyWith({int? startIndex, int? endIndex}) =>
      CitationSource(startIndex: startIndex ?? this.startIndex, endIndex: endIndex ?? this.endIndex);

  factory CitationSource.fromJson(Map<String, dynamic> json) => _$CitationSourceFromJson(json);

  Map<String, dynamic> toJson() => _$CitationSourceToJson(this);
}

@JsonSerializable()
class Content {
  @JsonKey(name: "parts")
  final List<Part> parts;
  @JsonKey(name: "role")
  final String role;

  const Content({this.parts = const [], this.role = ''});

  Content copyWith({List<Part>? parts, String? role}) => Content(parts: parts ?? this.parts, role: role ?? this.role);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class Part {
  @JsonKey(name: "text")
  final String text;

  Part({this.text = ''});

  Part copyWith({String? text}) => Part(text: text ?? this.text);

  factory Part.fromJson(Map<String, dynamic> json) => _$PartFromJson(json);

  Map<String, dynamic> toJson() => _$PartToJson(this);
}

@JsonSerializable()
class UsageMetadata {
  @JsonKey(name: "promptTokenCount")
  final int promptTokenCount;
  @JsonKey(name: "candidatesTokenCount")
  final int candidatesTokenCount;
  @JsonKey(name: "totalTokenCount")
  final int totalTokenCount;
  @JsonKey(name: "promptTokensDetails")
  final List<TokensDetail> promptTokensDetails;
  @JsonKey(name: "candidatesTokensDetails")
  final List<TokensDetail> candidatesTokensDetails;

  const UsageMetadata({
    this.promptTokenCount = 0,
    this.candidatesTokenCount = 0,
    this.totalTokenCount = 0,
    this.promptTokensDetails = const [],
    this.candidatesTokensDetails = const [],
  });

  UsageMetadata copyWith({
    int? promptTokenCount,
    int? candidatesTokenCount,
    int? totalTokenCount,
    List<TokensDetail>? promptTokensDetails,
    List<TokensDetail>? candidatesTokensDetails,
  }) => UsageMetadata(
    promptTokenCount: promptTokenCount ?? this.promptTokenCount,
    candidatesTokenCount: candidatesTokenCount ?? this.candidatesTokenCount,
    totalTokenCount: totalTokenCount ?? this.totalTokenCount,
    promptTokensDetails: promptTokensDetails ?? this.promptTokensDetails,
    candidatesTokensDetails: candidatesTokensDetails ?? this.candidatesTokensDetails,
  );

  factory UsageMetadata.fromJson(Map<String, dynamic> json) => _$UsageMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$UsageMetadataToJson(this);
}

@JsonSerializable()
class TokensDetail {
  @JsonKey(name: "modality")
  final String modality;
  @JsonKey(name: "tokenCount")
  final int tokenCount;

  TokensDetail({this.modality = '', this.tokenCount = 0});

  TokensDetail copyWith({String? modality, int? tokenCount}) =>
      TokensDetail(modality: modality ?? this.modality, tokenCount: tokenCount ?? this.tokenCount);

  factory TokensDetail.fromJson(Map<String, dynamic> json) => _$TokensDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TokensDetailToJson(this);
}
