import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('flutter integration test', () {
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() {
      if (driver != null) {
        driver.close();
      }
    });

    void main() {
      group('Kitchen', () {
        FlutterDriver driver;

        setUpAll(() async {
          driver = await FlutterDriver.connect();
        });

        tearDownAll(() async {
          if (driver != null) {
            driver.close();
          }
        });

        test('check flutter driver health', () async {
          Health health = await driver.checkHealth();
          print(health.status);
        });

        test("Test sign in", () async {
          final timeline = await driver.traceAction(() async {
            final emailFieldFinder = find.byValueKey('email');
            final passwordFieldFinder = find.byValueKey('password');
            final submitButtonFinder = find.byValueKey('signIn');

            await driver.waitFor(emailFieldFinder);
            await driver.tap(emailFieldFinder);
            await driver.enterText('asanka@gmail.com');
            await driver.waitFor(find.text('asanka@gmail.com'));

            await driver.waitFor(passwordFieldFinder);
            await driver.tap(passwordFieldFinder);
            await driver.enterText('123456');
            await driver.waitFor(find.text('123456'));

            await driver.waitFor(submitButtonFinder);
            await driver.tap(submitButtonFinder);
          });
          final summary = new TimelineSummary.summarize(timeline);
          summary.writeSummaryToFile('login', pretty: true);
        });

        test("sign test with empty values", () async {
          await driver.runUnsynchronized(() async {
            final signInButton = find.byValueKey('SignInbutton');
            await driver.waitFor(signInButton);
            await driver.tap(signInButton);
          });
        });

        test("add item", () async {
          final addButton = find.byValueKey('addbutton');
          await driver.waitFor(addButton);
          await driver.tap(addButton);

          final name = find.byValueKey('name');
          await driver.waitFor(name);
          await driver.tap(name);
          await driver.enterText('Test ...');
          await driver.waitFor(find.text('Test ...'));
        });
      });
    }
  });
}
