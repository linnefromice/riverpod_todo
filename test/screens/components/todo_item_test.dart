import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_todo/screens/components/todo_item.dart';
import 'package:riverpod_todo/screens/components/toolbar.dart';

void main() {
  testWidgets('Title has a title', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: TodoItem()
      ),
    ));
    expect(find.text('todo.description'), findsOneWidget);
  });
}