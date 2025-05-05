# Flutter Hung Chatbot

Flutter Hung Chatbot is a cross-platform chatbot application built using Flutter. It uses the Gemini API from Google. Refer to the documentation here: https://ai.google.dev/gemini-api/docs

## Features

- **Multi-Platform Support**: Runs on Android, iOS, web, and desktop platforms.
- **Customizable Flavors**: Includes development, staging, and production configurations for flexible environment management.
- **Responsive Design**: Adapts to various screen sizes and orientations for an optimal user experience.
- **Clean Architecture**: Organized codebase for scalability, maintainability, and ease of development.
- **Bloc State Management**: This project uses Bloc to handle state transitions and ensure a smooth user experience.
- **Chat Feature**: Includes both normal and stream modes.

## Getting Started

### Installation

> **Note**: This project requires Flutter version 3.29.2. Please ensure you have this version installed before proceeding.

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/flutter-hung-chatbot.git
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Create **".env, .env.staging, .env.production"** files in the "env" folder (based on the `env_template.txt`):
   ```bash
   ENV=dev

   API_KEY=YOUR_API_KEY
   GOOGLE_URL=https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash
   ```

4. Get the API_KEY:\
   Obtain the API_KEY from [**aistudio.google.com**](https://aistudio.google.com) and paste it into the "env" files.

5. Run the application:\
   Choose a variant/flavor and run it (refer to `.vscode/launch.json` and `.idea/runConfigurations`).

### Flavors

This project supports multiple flavors for different environments:

- **Development**: `dev`
- **Staging**: `stag`
- **Production**: `prod`

To run a specific flavor, use the following command:
```bash
flutter run --flavor <flavor-name> -t lib/main.dart
```

Example:
```bash
flutter run --flavor dev -t lib/main.dart
```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes with clear and descriptive messages.
4. Submit a pull request for review.

## Contact

For any inquiries or support, please contact: vankhanhhungit@gmail.com
