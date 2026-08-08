

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vahancheck/main.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MyApp(initialLocale: Locale('en', 'US')),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MyApp), findsOneWidget);
  });
}