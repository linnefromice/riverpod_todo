import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_todo/screens/components/toolbar.dart';

void main() {
  testWidgets('Title has a title', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Toolbar()
      ),
    ));
    expect(find.text('NN items left'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);
  });
}