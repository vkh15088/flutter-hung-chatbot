import 'package:flutter_hung_chatbot/features/chat/domain/entities/gemini/gemini_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gemini_base_dto.g.dart';

@JsonSerializable()
class CandidateDto {
  @JsonKey(name: "content")
  final ContentDto content;
  @JsonKey(name: "finishReason")
  final String finishReason;
  @JsonKey(name: "citationMetadata")
  final CitationMetadataDto citationMetadata;
  @JsonKey(name: "avgLogprobs")
  final double avgLogprobs;

  const CandidateDto({
    this.content = const ContentDto(),
    this.finishReason = '',
    this.citationMetadata = const CitationMetadataDto(),
    this.avgLogprobs = 0,
  });

  CandidateDto copyWith({
    ContentDto? content,
    String? finishReason,
    CitationMetadataDto? citationMetadata,
    double? avgLogprobs,
  }) => CandidateDto(
    content: content ?? this.content,
    finishReason: finishReason ?? this.finishReason,
    citationMetadata: citationMetadata ?? this.citationMetadata,
    avgLogprobs: avgLogprobs ?? this.avgLogprobs,
  );

  factory CandidateDto.fromJson(Map<String, dynamic> json) => _$CandidateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateDtoToJson(this);

  Candidate toEntity() {
    return Candidate(
      content: content.toEntity(),
      finishReason: finishReason,
      citationMetadata: citationMetadata.toEntity(),
      avgLogprobs: avgLogprobs,
    );
  }

  static CandidateDto fromEntity(Candidate candidate) {
    return CandidateDto(
      content: ContentDto.fromEntity(candidate.content),
      finishReason: candidate.finishReason,
      citationMetadata: CitationMetadataDto.fromEntity(candidate.citationMetadata),
      avgLogprobs: candidate.avgLogprobs,
    );
  }
}

@JsonSerializable()
class CitationMetadataDto {
  @JsonKey(name: "citationSources")
  final List<CitationSourceDto> citationSources;

  const CitationMetadataDto({this.citationSources = const []});

  CitationMetadataDto copyWith({List<CitationSourceDto>? citationSources}) =>
      CitationMetadataDto(citationSources: citationSources ?? this.citationSources);

  factory CitationMetadataDto.fromJson(Map<String, dynamic> json) => _$CitationMetadataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CitationMetadataDtoToJson(this);

  CitationMetadata toEntity() {
    return CitationMetadata(
      citationSources: citationSources.map((citationSource) => citationSource.toEntity()).toList(),
    );
  }

  static CitationMetadataDto fromEntity(CitationMetadata citationMetadata) {
    return CitationMetadataDto(
      citationSources:
          citationMetadata.citationSources
              .map((citationSource) => CitationSourceDto.fromEntity(citationSource))
              .toList(),
    );
  }
}

@JsonSerializable()
class CitationSourceDto {
  @JsonKey(name: "startIndex")
  final int startIndex;
  @JsonKey(name: "endIndex")
  final int endIndex;

  const CitationSourceDto({this.startIndex = 0, this.endIndex = 0});

  CitationSourceDto copyWith({int? startIndex, int? endIndex}) =>
      CitationSourceDto(startIndex: startIndex ?? this.startIndex, endIndex: endIndex ?? this.endIndex);

  factory CitationSourceDto.fromJson(Map<String, dynamic> json) => _$CitationSourceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CitationSourceDtoToJson(this);

  CitationSource toEntity() {
    return CitationSource(startIndex: startIndex, endIndex: endIndex);
  }

  static CitationSourceDto fromEntity(CitationSource citationSource) {
    return CitationSourceDto(startIndex: citationSource.startIndex, endIndex: citationSource.endIndex);
  }
}

@JsonSerializable()
class ContentDto {
  @JsonKey(name: "parts")
  final List<PartDto> parts;
  @JsonKey(name: "role")
  final String role;

  const ContentDto({this.parts = const [], this.role = ''});

  ContentDto copyWith({List<PartDto>? parts, String? role}) =>
      ContentDto(parts: parts ?? this.parts, role: role ?? this.role);

  factory ContentDto.fromJson(Map<String, dynamic> json) => _$ContentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ContentDtoToJson(this);

  Content toEntity() {
    return Content(parts: parts.map((part) => part.toEntity()).toList(), role: role);
  }

  static ContentDto fromEntity(Content content) {
    return ContentDto(parts: content.parts.map((part) => PartDto.fromEntity(part)).toList(), role: content.role);
  }
}

@JsonSerializable()
class PartDto {
  @JsonKey(name: "text")
  final String text;

  PartDto({this.text = ''});

  PartDto copyWith({String? text}) => PartDto(text: text ?? this.text);

  factory PartDto.fromJson(Map<String, dynamic> json) => _$PartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PartDtoToJson(this);

  Part toEntity() {
    return Part(text: text);
  }

  static PartDto fromEntity(Part part) {
    return PartDto(text: part.text);
  }
}

@JsonSerializable()
class UsageMetadataDto {
  @JsonKey(name: "promptTokenCount")
  final int promptTokenCount;
  @JsonKey(name: "candidatesTokenCount")
  final int candidatesTokenCount;
  @JsonKey(name: "totalTokenCount")
  final int totalTokenCount;
  @JsonKey(name: "promptTokensDetails")
  final List<TokensDetailDto> promptTokensDetails;
  @JsonKey(name: "candidatesTokensDetails")
  final List<TokensDetailDto> candidatesTokensDetails;

  const UsageMetadataDto({
    this.promptTokenCount = 0,
    this.candidatesTokenCount = 0,
    this.totalTokenCount = 0,
    this.promptTokensDetails = const [],
    this.candidatesTokensDetails = const [],
  });

  UsageMetadataDto copyWith({
    int? promptTokenCount,
    int? candidatesTokenCount,
    int? totalTokenCount,
    List<TokensDetailDto>? promptTokensDetails,
    List<TokensDetailDto>? candidatesTokensDetails,
  }) => UsageMetadataDto(
    promptTokenCount: promptTokenCount ?? this.promptTokenCount,
    candidatesTokenCount: candidatesTokenCount ?? this.candidatesTokenCount,
    totalTokenCount: totalTokenCount ?? this.totalTokenCount,
    promptTokensDetails: promptTokensDetails ?? this.promptTokensDetails,
    candidatesTokensDetails: candidatesTokensDetails ?? this.candidatesTokensDetails,
  );

  factory UsageMetadataDto.fromJson(Map<String, dynamic> json) => _$UsageMetadataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UsageMetadataDtoToJson(this);

  UsageMetadata toEntity() {
    return UsageMetadata(
      promptTokenCount: promptTokenCount,
      candidatesTokenCount: candidatesTokenCount,
      totalTokenCount: totalTokenCount,
      promptTokensDetails: promptTokensDetails.map((tokenDetail) => tokenDetail.toEntity()).toList(),
      candidatesTokensDetails: candidatesTokensDetails.map((tokenDetail) => tokenDetail.toEntity()).toList(),
    );
  }

  static UsageMetadataDto fromEntity(UsageMetadata usageMetadata) {
    return UsageMetadataDto(
      promptTokenCount: usageMetadata.promptTokenCount,
      candidatesTokenCount: usageMetadata.candidatesTokenCount,
      totalTokenCount: usageMetadata.totalTokenCount,
      promptTokensDetails:
          usageMetadata.promptTokensDetails.map((tokenDetail) => TokensDetailDto.fromEntity(tokenDetail)).toList(),
      candidatesTokensDetails:
          usageMetadata.candidatesTokensDetails.map((tokenDetail) => TokensDetailDto.fromEntity(tokenDetail)).toList(),
    );
  }
}

@JsonSerializable()
class TokensDetailDto {
  @JsonKey(name: "modality")
  final String modality;
  @JsonKey(name: "tokenCount")
  final int tokenCount;

  TokensDetailDto({this.modality = '', this.tokenCount = 0});

  TokensDetailDto copyWith({String? modality, int? tokenCount}) =>
      TokensDetailDto(modality: modality ?? this.modality, tokenCount: tokenCount ?? this.tokenCount);

  factory TokensDetailDto.fromJson(Map<String, dynamic> json) => _$TokensDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokensDetailDtoToJson(this);

  TokensDetail toEntity() {
    return TokensDetail(modality: modality, tokenCount: tokenCount);
  }

  static TokensDetailDto fromEntity(TokensDetail tokensDetail) {
    return TokensDetailDto(modality: tokensDetail.modality, tokenCount: tokensDetail.tokenCount);
  }
}
