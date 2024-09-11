# Video Feed App

This Flutter application is a video feed app that allows users to scroll through a feed of videos, view video details, and see replies to each video. The app follows clean architecture principles and uses Provider for state management.


## Project Demonstration

[![Watch the video](https://img.youtube.com/vi/xc1iRcKyRlE/0.jpg)](https://www.youtube.com/watch?v=xc1iRcKyRlE)


## Project Structure

The project is organized into the following directories:

```
lib/
├── domain/
│   ├── models/
│   └── services/
├── presentation/
│   └── screens/
├── providers/
├── widgets/
└── main.dart
```

## File Descriptions

### Domain

#### `lib/domain/models/post.dart`
- **Purpose**: Defines the `Post` model class.
- **Usage**: Represents the structure of a video post, including properties like id, title, video link, etc.
- **Contribution**: Provides a consistent data structure for video posts throughout the app.

#### `lib/domain/services/api_service.dart`
- **Purpose**: Handles all API interactions.
- **Usage**: Contains methods for fetching posts and replies from the backend.
- **Contribution**: Centralizes all network requests, making it easier to manage and modify API interactions.

### Presentation

#### `lib/presentation/screens/video_feed_screen.dart`
- **Purpose**: Defines the main screen of the app.
- **Usage**: Displays the video feed and handles user interactions.
- **Contribution**: Serves as the primary user interface for browsing videos.

### Providers

#### `lib/providers/video_feed_provider.dart`
- **Purpose**: Manages the state of the main video feed.
- **Usage**: Fetches and stores the list of video posts.
- **Contribution**: Centralizes video feed state management, making it accessible throughout the app.

#### `lib/providers/video_replies_provider.dart`
- **Purpose**: Manages the state of video replies.
- **Usage**: Fetches and stores replies for each video post.
- **Contribution**: Handles state management for video replies, separating it from the main feed logic.

### Widgets

#### `lib/widgets/video_feed_item.dart`
- **Purpose**: Defines the widget for individual video items in the feed.
- **Usage**: Displays video information and handles navigation to replies.
- **Contribution**: Encapsulates the UI and logic for each video item, promoting reusability.

#### `lib/widgets/video_card.dart`
- **Purpose**: Defines the widget for playing videos and displaying video details.
- **Usage**: Handles video playback and displays video metadata.
- **Contribution**: Manages video playback functionality and UI, keeping it separate from the feed logic.

### Main

#### `lib/main.dart`
- **Purpose**: Entry point of the application.
- **Usage**: Sets up the app, including theming and provider configuration.
- **Contribution**: Initializes the app and sets up the provider architecture.

## Getting Started

To run this project:

1. Ensure you have Flutter installed on your machine.
2. Clone this repository.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to start the app on your connected device or emulator.

## Dependencies

This project relies on the following main dependencies:

- `provider`: For state management
- `http`: For making API requests
- `video_player`: For video playback functionality
- `flutter_spinkit`: For loading animations
- `fluttertoast`: For displaying toast messages

Ensure these are correctly listed in your `pubspec.yaml` file.

