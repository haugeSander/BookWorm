# Book worm

A flutter app for storing books, to allow for simple note-taking while reading and ability to summarize books when finished. The app is made with a template from my personal Notion book noting in mind. It is streamlined for non-fiction books, which I find personally the most rewarding to read. It has a local database implemented using ISAR. Everything is stored on-device.

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [License](#license)

## Getting Started

The application will be available for download as an .apk file in the forseeable future, meaning only for Android.
If the app has all the features intended it will be available on Play store or App store.

For now, it is possible to clone this repository and run it onto your own device.

### Prerequisites

These must be in place to use the project.
- Git, to be able to clone repository
- Flutter SDK
- Dart SDK
- Development IDE, such as VSC and Android Studio
- Emulator or Physical Device

### Installation

Step-by-step instructions on how to install and get the project running.

$ git clone https://github.com/username/repository.git
$ cd repository
$ flutter pub get
$ flutter run

## Project structure

book_worm/
│
├── android/             # Android specific files and configurations
│   ├── app/             # Android app source code
│   ├── build/           # Compiled Android build output
│   └── ...
│
├── ios/                 # iOS specific files and configurations
│   ├── Runner/          # iOS app source code
│   ├── Pods/            # Third-party libraries for iOS
│   ├── build/           # Compiled iOS build output
│   └── ...
│
├── fonts/              # Fonts used in project
│
├── lib/                 # Dart source code
│   ├── main.dart        # Entry point of the application
│   ├── screens/         # Screen widgets
│   ├── models/          # Data models
│   ├── services/        # Business logic and API services
│   ├── widgets/           # Utility functions
│   └── ...
│
├── test/                # Unit and widget tests
│   ├── widget_test.dart
│   └── ...
│
├── assets/              # Static files such as images, fonts, etc.
│   ├── images/          # Image files
│   ├── icons/           # Svg files
│   ├── fonts/           # Font files
│   └── ...
│
├── pubspec.yaml         # Flutter project dependencies and metadata
├── README.md            # Project readme file
├── .gitignore           # Git ignore file
└── ...

## License

This project is licensed under the MIT License - see the LICENSE file for details.
