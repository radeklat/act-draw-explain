import 'package:flutter_driver/driver_extension.dart';
import 'package:act_draw_explain/main.dart' as app;

void main() {
  // Run the tests with `flutter drive --target=test_driver/app.dart`

  enableFlutterDriverExtension();  // This line enables the extension.

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}