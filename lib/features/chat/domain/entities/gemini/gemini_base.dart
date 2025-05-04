class Candidate {
  final Content content;
  final String finishReason;
  final CitationMetadata citationMetadata;
  final double avgLogprobs;

  const Candidate({
    required this.content,
    required this.finishReason,
    required this.citationMetadata,
    required this.avgLogprobs,
  });
}

class CitationMetadata {
  final List<CitationSource> citationSources;

  const CitationMetadata({required this.citationSources});
}

class CitationSource {
  final int startIndex;
  final int endIndex;

  const CitationSource({required this.startIndex, required this.endIndex});
}

class Content {
  final List<Part> parts;
  final String role;

  const Content({required this.parts, required this.role});
}

class Part {
  final String text;

  const Part({required this.text});
}

class UsageMetadata {
  final int promptTokenCount;
  final int candidatesTokenCount;
  final int totalTokenCount;
  final List<TokensDetail> promptTokensDetails;
  final List<TokensDetail> candidatesTokensDetails;

  const UsageMetadata({
    required this.promptTokenCount,
    required this.candidatesTokenCount,
    required this.totalTokenCount,
    required this.promptTokensDetails,
    required this.candidatesTokensDetails,
  });
}

class TokensDetail {
  final String modality;
  final int tokenCount;

  const TokensDetail({required this.modality, required this.tokenCount});
}
