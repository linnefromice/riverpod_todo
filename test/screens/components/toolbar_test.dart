import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/screens/components/toolbar.dart';
import 'package:riverpod_todo/screens/home_page.dart';

void main() {
  testWidgets('has count & tags', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        home: Toolbar()
      ),
    ));
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Completed'), findsOneWidget);
  });

  testWidgets('has count of left items', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        uncompletedTodosCount.overrideWithProvider(Provider<int>((ref) => 3))
      ],
      child: MaterialApp(
        home: Toolbar()
      ),
    ));
    expect(find.text('3 items left'), findsOneWidget);
  });
}