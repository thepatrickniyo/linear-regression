
# Student Performance Predictor - Flutter Mobile App

## Overview
A cross-platform mobile application built with Flutter that provides students and educators with AI-powered academic performance predictions. The app connects to a machine learning API to predict student performance based on study habits, lifestyle factors, and academic history.

## Purpose & Vision
This mobile app serves as a practical tool for:
- **Students** - To understand how their study habits and lifestyle choices impact academic performance
- **Educators** - To identify students who may need additional support
- **Parents** - To monitor and optimize their children's study patterns
- **Researchers** - To analyze correlations between lifestyle factors and academic success

## Features

### 🎯 Core Functionality
- **Performance Prediction** - Get instant predictions based on study metrics
- **Interactive Input Forms** - User-friendly forms for entering student data
- **Real-time Results** - Immediate feedback on predicted performance scores
- **Data Validation** - Input validation to ensure accurate predictions

### 📱 Mobile Experience
- **Cross-platform** - Works on both iOS and Android devices
- **Responsive Design** - Optimized for different screen sizes
- **Intuitive UI** - Clean, modern interface following Material Design principles
- **Offline Capability** - Basic functionality available without internet connection

### 🔗 API Integration
- **REST API Consumption** - Seamless integration with the Student Performance API
- **HTTP Request Handling** - Robust network communication with error handling
- **JSON Data Processing** - Efficient parsing of prediction responses
- **Network Status Monitoring** - Connection status awareness

## Input Parameters
The app collects the following data points for prediction:

1. **📚 Hours Studied** - Daily/weekly study time input
2. **📊 Previous Scores** - Historical academic performance (0-100)
3. **🎭 Extracurricular Activities** - Participation in non-academic activities
4. **😴 Sleep Hours** - Average nightly sleep duration
5. **📝 Practice Papers** - Number of sample question papers completed

## App Architecture

### 📁 Project Structure
```
lib/
├── main.dart              # App entry point
├── models/               # Data models
├── services/             # API services
├── screens/              # UI screens
├── widgets/              # Reusable components
└── utils/                # Helper functions
```

### 🛠 Technology Stack
- **Flutter** - UI framework for cross-platform development
- **Dart** - Programming language
- **HTTP** - Network requests to the prediction API
- **Material Design** - UI/UX design system

## Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator (for iOS development)
- Android Emulator / Physical device

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd Flutter_app
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure API endpoint**
Update the API base URL in your configuration file to point to your running API server:
```dart
const String API_BASE_URL = 'http://your-api-server:8000';
```

4. **Run the application**
```bash
# Debug mode
flutter run

# Release mode
flutter run --release
```

## Usage Flow

### 1. **Data Input Screen**
- Students enter their study-related information
- Form validation ensures data quality
- Interactive sliders and input fields for better UX

### 2. **Prediction Processing**
- App sends HTTP POST request to the API
- Loading indicator shows processing status
- Error handling for network issues

### 3. **Results Display**
- Performance prediction displayed prominently
- Visual indicators (progress bars, charts)
- Recommendations based on prediction results

### 4. **Additional Features**
- History of previous predictions
- Study tips and recommendations
- Performance trend analysis

## API Integration

The app communicates with the Student Performance Prediction API:

```dart
// Example API call
Future<double> predictPerformance(StudentData data) async {
  final response = await http.post(
    Uri.parse('$API_BASE_URL/predict'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data.toJson()),
  );
  
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    return result['prediction'];
  } else {
    throw Exception('Failed to get prediction');
  }
}
```

## Development Commands

```bash
# Install dependencies
flutter pub get

# Run in debug mode
flutter run

# Build for Android
flutter build apk

# Build for iOS
flutter build ios

# Run tests
flutter test

# Analyze code
flutter analyze
```

## Supported Platforms
- ✅ **Android** (API level 21+)
- ✅ **iOS** (iOS 11.0+)
- ✅ **Web** (Chrome, Firefox, Safari)
- ✅ **Desktop** (Windows, macOS, Linux)

## Future Enhancements
- 📈 Performance tracking over time
- 🎯 Personalized study recommendations
- 📊 Data visualization and charts
- 🔔 Study reminder notifications
- 👥 Multi-user support for families/classes
- 🌐 Offline prediction capabilities
- 📱 Widget support for quick predictions

## Contributing
This app is part of an academic machine learning project demonstrating the practical application of linear regression models in educational technology.

## Demo Video Requirements
For demonstration purposes, the app includes:
- Complete prediction workflow demonstration
- API integration testing via Swagger UI
- Input validation and error handling
- Cross-platform compatibility showcase
- Performance metrics display

---

**Note**: This Flutter app is designed to work in conjunction with the Student Performance Prediction API. Ensure the API server is running before using the mobile application for live predictions.
