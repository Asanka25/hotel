import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel/screens/authenticate/sign_in.dart';

void main() {
  testWidgets("sign up test", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignIn()));
    await tester.pumpAndSettle();
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(RaisedButton), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);

  });
}
