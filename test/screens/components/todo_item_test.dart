import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_todo/models/todo.dart';
import 'package:riverpod_todo/models/todo_list.dart';
import 'package:riverpod_todo/screens/components/todo_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/screens/home_page.dart';

void main() {
  var uncompleted = Todo(
    id: 'todo_uncompleted_id',
    description: 'todo_uncompleted_description',
    completed: false
  );
  var completed = Todo(
    id: 'todo_completed_id',
    description: 'todo_completed_description',
    completed: true
  );
  testWidgets('default display', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        currentTodo.overrideWithValue(uncompleted)
      ],
      child: MaterialApp(
        home: TodoItem()
      ),
    ));
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });
  testWidgets('when uncompleted todo', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        currentTodo.overrideWithValue(uncompleted)
      ],
      child: MaterialApp(
        home: TodoItem()
      ),
    ));
    var checkbox = find.byType(Checkbox);
    expect(
      tester.widget(checkbox),
      isA<Checkbox>().having((s) => s.value, 'value', false)
    );
  });
  testWidgets('when completed todo', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        currentTodo.overrideWithValue(completed)
      ],
      child: MaterialApp(
          home: TodoItem()
      ),
    ));
    expect(
      tester.widget(find.byType(Checkbox)),
      isA<Checkbox>().having((s) => s.value, 'value', true)
    );
  });
}