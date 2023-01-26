# nsio_assignment
## About project structure
### The project is structured as follows:
- `lib` contains the source code for the project
    - `lib/bloc` contains the business logic components of the project
    - `lib/custom_widgets` contains the custom widgets used in the project
    - `lib/screens` contains the screens of the project
    - `lib/utils` contains the extensions, color and utilities used in the project
    - `lib/main.dart` is the entry point of the project
- `test` contains the test files for the project
    - `test/widget_test.dart` contains the test for the default flutter project
    - `test/cubit_test.dart` contains the test for the cubit
- `packages` contains the dependencies of the project
    - `packages/api_client` contains the api client for the project
    - `packages/user_preferences` contains the shared preferences logic for the project
## To download the project
- Download the app-release.apk file which is present in the root directory of the project
- Install the apk file on your android device
## To run the project
- Clone the project
- Run `flutter pub get` to download the dependencies
- Run `flutter run` to run the project
## To run the tests
- Run `flutter test` to run the tests
## TO run the test for api_client package
- Run `flutter test api_client_test.dart` in the `packages/api_client/lib/test` directory
