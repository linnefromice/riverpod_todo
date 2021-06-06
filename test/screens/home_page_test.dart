import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/screens/components/title.dart' as c;
import 'package:riverpod_todo/screens/components/toolbar.dart';
import 'package:riverpod_todo/screens/home_page.dart';

void main() {
  testWidgets('have Title,TextField,Toolbar', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        home: HomePage()
      ),
    ));
    expect(find.byType(c.Title), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(Toolbar), findsOneWidget);
  });

  final addTodoInput = find.byKey(addTodoKey);
  final activeFilterButton = find.byKey(activeFilterKey);
  final firstItem = find.byKey(const Key('todo-0'));
  final firstCheckbox = find.descendant(
    of: firstItem,
    matching: find.byType(Checkbox),
  );
  final secondItem = find.byKey(const Key('todo-1'));
  final secondCheckbox = find.descendant(
    of: secondItem,
    matching: find.byType(Checkbox),
  );
  final thirdItem = find.byKey(const Key('todo-2'));
  final thirdCheckbox = find.descendant(
    of: thirdItem,
    matching: find.byType(Checkbox),
  );

  testWidgets('Render the default todos', (tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        home: HomePage()
      )
    ));
    expect(
      find.descendant(of: firstItem, matching: find.text('hi')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: secondItem, matching: find.text('hello')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: thirdItem, matching: find.text('bonjour')),
      findsOneWidget,
    );
  });
}