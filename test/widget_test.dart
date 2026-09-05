// // Basic smoke test: verifies the app boots and renders without throwing.
// //
// // Note: MariaVaiApp initializes Firebase and routing in main.dart before
// // runApp() is called, so this test builds the widget directly rather than
// // re-running main(), to avoid needing a real Firebase connection in tests.
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:mariavai_services/main.dart';
//
// void main() {
//   testWidgets('MariaVaiApp builds without throwing', (WidgetTester tester) async {
//     await tester.pumpWidget(const MariaVaiApp());
//     await tester.pump();
//
//     // The app should have rendered a MaterialApp-based widget tree.
//     expect(find.byType(MaterialApp), findsOneWidget);
//   });
// }
