import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_todo/models/todo.dart';
import 'package:riverpod_todo/screens/components/todo_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/screens/home_page.dart';

void main() {
  testWidgets('default display', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        currentTodo.overrideWithValue(Todo(
          id: 'test_id',
          description: 'test_description',
          completed: true
        ))
      ],
      child: MaterialApp(
        home: TodoItem()
      ),
    ));
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });
}