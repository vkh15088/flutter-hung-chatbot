import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavor { dev, stag, prod }

class F {
  static late final Flavor appFlavor;
  static final _envFolder = 'env/';
  static String get name => appFlavor.name;
  static String get getEnv => dotenv.get('ENV', fallback: 'dev');
  static String get getApiKey => dotenv.get('API_KEY', fallback: '');
  static String get getGoogleApi => dotenv.get('GOOGLE_URL', fallback: '');

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Chatbot Dev';
      case Flavor.stag:
        return 'Chatbot Stag';
      case Flavor.prod:
        return 'Chatbot';
    }
  }

  static String get envFile {
    switch (appFlavor) {
      case Flavor.dev:
        return '$_envFolder.env';
      case Flavor.stag:
        return '$_envFolder.env.staging';
      case Flavor.prod:
        return '$_envFolder.env.production';
    }
  }
}
