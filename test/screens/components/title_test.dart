import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_todo/screens/components/title.dart' as c;

void main() {
  testWidgets('Title has a title', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: c.Title()
      ),
    ));
    expect(find.text('TODOS'), findsOneWidget);
  });
}