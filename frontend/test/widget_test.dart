// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/main.dart';

void main() {
  testWidgets('PoshanEye app loads HomeScreen test', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the PoshanEye app bar appears.
    expect(find.text('PoshanEye'), findsWidgets);

    // Verify that the input fields are present.
    expect(find.byType(TextField), findsWidgets);

    // Verify that the Predict button is present.
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify that the result text is present.
    expect(find.text('Result: No result'), findsOneWidget);
  });
}
