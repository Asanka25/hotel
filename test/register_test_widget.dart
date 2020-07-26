import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel/screens/authenticate/register.dart';

void main() {
  testWidgets("sign up test", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Register()));
    await tester.pumpAndSettle();
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(RaisedButton), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });
}
