
## Currency Portal

A Flutter application that provides real-time and historical currency conversion data. The app features a clean and intuitive UI, allowing users to convert currencies and view historical exchange rates through interactive charts.

### Flutter Version:
- Channel stable, 3.22.3

### Features:
- **Real-Time Currency Conversion**: Convert between multiple currencies with up-to-date exchange rates.
- **Historical Data Visualization**: View historical exchange rates with interactive charts.
- **Offline Support**: Save and access currency data offline using Hive.
- **Dependency Injection**: Efficiently manage dependencies with a service locator pattern.
- **Unit Tests**: Test coverage for reliable and maintainable code.


### Main Page Views:
The app features three main page views covering the requested functionalities:
1. **Currency Conversion**: 
   ![Screenshot 2024-08-04 030402](https://github.com/user-attachments/assets/502f0e86-4fea-4dee-9909-87ee9bcc025b)

2. **Currency History/Timeline**:
  ![Screenshot 2024-08-04 030432](https://github.com/user-attachments/assets/258b58d8-721e-4b5f-98f8-5e465c7cc0d0)

3. **List of All Currencies**:
  ![Screenshot 2024-08-04 030441](https://github.com/user-attachments/assets/567dffec-7ab4-4ff0-bc1c-a50386e0947d)

### Flavors:
This app has two Flutter flavors (not native ones) to handle different API URLs for development and production environments:
- **Development Flavor**: Uses a mock API (`wiremockapi`) for extensive testing.
- **Production Flavor**: Uses the `forexrateapi` with a limit of 100 free tests. Please use it carefully.

### Environment Variables:
Create a `.env` file in the root directory and add the following:
```env
PROD_CURRENCY_API_KEY={forexrateapi API key}
DEV_CURRENCY_API_KEY={test API key for wiremock}
```

#### Running the App:
- **Development Flavor**:
  ```sh
  flutter run --target lib/main_dev.dart
  ```
- **Production Flavor**:
  ```sh
  flutter run --target lib/main.dart
  ```

We opted not to use native flavors as we don't need different apps with different package names, icons, or any more complex configurations. We just needed to differentiate between the dev and prod APIs. A `FlavorConfig` class is used to handle this.

### Architecture:
The project follows clean architecture principles and uses the Bloc state management pattern. This ensures a scalable, maintainable, and testable codebase by separating concerns into distinct layers.

#### Clean Architecture:
- **Presentation Layer**: Contains UI components and the Bloc/Cubit implementations.
- **Domain Layer**: Contains business logic, including use cases and entities.
- **Data Layer**: Manages data sources, repositories, and models.

#### File Structure:
- **lib**
  - **core**: Contains core utilities and services used across the app.
    - **api**: Handles API-related utilities.
    - **constants**: Stores constant values used throughout the app.
    - **extensions**: Provides extensions for different types.
    - **flavor**: Manages flavor-specific configurations.
    - **resources**: Manages resources like images and strings.
    - **time**: Contains time-related utilities.
    - **network**: Handles network-related utilities.
    - **errors**: Contains custom error classes and exceptions.
    - **usecases**: Base use case classes.
    - **utils**: General utilities and constants.
  - **features**: Contains the different features of the app, each with its own sub-directory.
    - **currency**: Manages currency-related features.
      - **data**: Handles data sources, repositories, and models.
        - **datasources**: Contains API services and local data sources.
        - **models**: Data models and DTOs.
        - **repositories**: Implements repository interfaces.
      - **domain**: Contains business logic, use cases, and entities.
        - **entities**: Core entities representing the app's core data structures.
        - **repositories**: Repository interfaces.
        - **usecases**: Business logic implementations.
      - **presentation**: Manages UI components, widgets, and Bloc implementations.
        - **bloc**: Bloc and Cubit implementations for state management.
        - **pages**: Main pages and screens.
          - **pageviews**: Contains pages used inside a PageView widget.
          - **states**: UI for the state of different screens.
        - **widgets**: Reusable UI components.
  - **main.dart**: Entry point for the production flavor.
  - **main_dev.dart**: Entry point for the development flavor.
  - **main_global.dart**: Configures the app for both development and production flavors.
  - **dependency_injection.dart**: Sets up service locators and dependency injection.

### Local Storage:
We use Hive for local storage due to its ease of use, automation capabilities, and potential for data security if needed. Hive is a lightweight and fast key-value database written in pure Dart, and it provides a great way to store and retrieve data offline. 

### Image Loading:
We use the `cached_network_image` package to cache images and provide placeholders for errors and loading states. Additionally, we created a custom widget to handle cases where no flag is returned from the flag API. This widget uses a JSON file containing currency codes, country codes, and flags as base64. If a flag isn't available in the API, we create a file from the base64 data and display it. For cryptocurrencies like Bitcoin, which don't have country flags, we show a white placeholder, following standard practices across currency platforms.

### Getting Started:
1. **Clone the repository**:
   ```sh
    git clone https://github.com/RamyGomaa/currency-portal.git
   ```
2. **Install dependencies**:
   ```sh
   flutter pub get
   ```
3. **Run the app**:
   ```sh
   flutter run --target lib/main_dev.dart
   ```

### Contributing:
Contributions are welcomed!

### License:
This project is licensed under the MIT License.

