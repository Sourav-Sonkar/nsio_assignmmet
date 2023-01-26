// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nsio_assignment/custom_widgets/custom_icon_button.dart';
import 'package:nsio_assignment/main.dart';

void main() {
  var app = MyApp(apiClient: ApiClient());
  testWidgets("Login screen tap elvated button", (tester) async {
    await tester.pumpWidget(app);
    final buttonFinder = find.byType(ElevatedButton);
    expect(buttonFinder, findsOneWidget);
    tester.tap(buttonFinder);
  });
  
  testWidgets(" custom icon button", (tester) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient(), isloggedIn: true));
    final buttonFinder = find.byType(CustomIconButton);
    expect(buttonFinder, findsWidgets);
    tester.tap(buttonFinder);
  });

  testWidgets("Login screen sign up text", (tester) async {
    await tester.pumpWidget(app);
    final signInTextFinder = find.text("Sign in with");
    expect(signInTextFinder, findsOneWidget);
  });
  
  testWidgets("find Time to Cheers! Choose your beer...", (tester) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient(), isloggedIn: true));
    final textFinder = find.text("Time to Cheers! Choose your beer...");
    expect(textFinder, findsOneWidget);
  });
}
