# Flutter TDD Clean Architecture User Management Project

This Flutter/Dart project is designed to demonstrate Test-Driven Development (TDD) and Clean Architecture principles while implementing user management functionalities. The project utilizes the Bloc and Cubit patterns for presentation and interacts with a mock server provided by [MockAPI.io](https://mockapi.io/).

## Project Overview

The main objectives of this project are:

1. Implement user listing and user addition functionalities.
2. Demonstrate TDD and Clean Architecture principles for maintainable code.
3. Use the Bloc and Cubit patterns for presentation logic.

## Project Structure

The project follows a modular and organized structure to ensure separation of concerns and maintainability:

- `lib/`: Contains the Dart code for the main application.
    - `core/`: Includes shared application-wide code and configurations.
    - `data/`: Handles data sources, repositories, and data models.
    - `domain/`: Contains use cases, entities, and interfaces defining the business logic.
    - `presentation/`: Manages the user interface and presentation logic using Bloc and Cubit.
- `test/`: Holds the unit and widget tests for TDD.

## Dependencies

This project uses the following key dependencies:

- [Flutter](https://flutter.dev/): The main framework for building the mobile application.
- [Bloc](https://pub.dev/packages/bloc): For managing the presentation logic.
- [Mockito](https://pub.dev/packages/mockito): For mocking dependencies during testing.
- [Equatable](https://pub.dev/packages/equatable): To compare objects in a more intuitive way.

Make sure to check the `pubspec.yaml` file for a complete list of dependencies.

## Getting Started

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/pablin202/your-project.git
    ```
2. Navigate to the project's directory:
   ```bash
    cd your-project
    ```
3. Install the project dependencies using Flutter:   
    ```bash
    flutter pub get
    ```
4. Run the application:
    ```bash
    flutter run
    ```
   
## Getting Started

You can run unit tests and widget tests using the following commands:

    ```bash
    flutter test
    ```

## API Server 

This project interacts with a mock server provided by MockAPI.io. Ensure you have an active internet connection to use the server. The server URL can be configured in the lib/data/datasources/user_remote_data_source.dart file.

