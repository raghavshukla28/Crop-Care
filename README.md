# TENSOR - Crop Disease Detection App

A Flutter-based mobile application designed to help farmers detect crop diseases, monitor weather conditions, and access cultivation tips in both English and Hindi.

## Key Features

* Real-time crop disease detection using AI
* Live weather monitoring and forecasts 
* 100+ cultivation tips and best practices
* Bilingual interface (English/Hindi)
* ChatGPT integration for farming assistance

## Getting Started

### Prerequisites

* Flutter (latest stable version)
* Dart SDK
* Android Studio / VS Code
* TensorFlow Lite model
* OpenWeatherMap API key

### Installation

1. Clone the repository
```bash
git clone [repository-url]
```

2. Install dependencies
```bash
flutter pub get
```

3. Add your OpenWeatherMap API key in `lib/screens/weather_forecast_screen.dart`
```dart
final String apiKey = 'YOUR_API_KEY_HERE';
```

4. Place your TensorFlow Lite model in `assets/model.tflite`

5. Run the app
```bash
flutter run
```

## App Structure

```
lib/
├── main.dart                    # App entry point
├── disease_detection.dart       # Disease detection logic
├── app_localizations.dart       # Translations
└── screens/
    ├── home_screen.dart        # Main dashboard
    ├── weather_forecast.dart    # Weather features
    └── cultivation_tips.dart    # Farming tips
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^latest_version
  tflite: ^latest_version
  image_picker: ^latest_version
  url_launcher: ^latest_version
  flutter_localizations: ^latest_version
  google_fonts: ^latest_version
```

## Features Details

### Disease Detection
- Uses TensorFlow Lite for on-device inference
- Camera integration for image capture
- Image processing and analysis
- Disease identification and recommendations

### Weather Monitoring
- Real-time weather data
- Location-based forecasts
- Agricultural weather metrics
- Temperature and precipitation data

### Cultivation Tips
- Comprehensive farming guidelines
- Seasonal recommendations
- Pest control advice
- Soil management tips

### Localization
- Complete English/Hindi support
- Easy language switching
- Localized content and UI elements

## Usage

1. Disease Detection:
   - Tap the camera icon
   - Take a photo of the affected crop
   - View analysis results

2. Weather:
   - Access current conditions
   - View forecasts
   - Check agricultural metrics

3. Cultivation Tips:
   - Browse categorized tips
   - Search for specific advice
   - Access seasonal guidelines

4. Language:
   - Access settings menu
   - Select preferred language
   - UI updates automatically

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create Pull Request

## License

This project is licensed under the MIT License
