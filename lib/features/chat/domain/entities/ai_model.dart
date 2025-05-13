enum AIModel {
  geminiFlash20,
  geminiFlashLite20,
  geminiFlash15,
  geminiPro15;

  const AIModel();

  String get apiIdentifier {
    switch (this) {
      case AIModel.geminiFlash20:
        return 'gemini-2.0-flash';
      case AIModel.geminiFlashLite20:
        return 'gemini-2.0-flash-lite';
      case AIModel.geminiFlash15:
        return 'gemini-1.5-flash';
      case AIModel.geminiPro15:
        return 'gemini-1.5-pro';
    }
  }

  String get displayName {
    switch (this) {
      case AIModel.geminiFlash20:
        return 'Gemini 2.0 Flash';
      case AIModel.geminiFlashLite20:
        return 'Gemini 2.0 Flash Lite';
      case AIModel.geminiFlash15:
        return 'Gemini 1.5 Flash';
      case AIModel.geminiPro15:
        return 'Gemini 1.5 Pro';
    }
  }

  static List<AIModel> get allModels => AIModel.values;

  static AIModel get defaultModel => AIModel.geminiFlash20;
}
