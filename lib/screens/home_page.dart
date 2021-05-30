import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/todo.dart';
import '../models/todo_list.dart';
import 'components/title.dart' as c;
import 'components/todo_item.dart';
import 'components/toolbar.dart';

final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});
final filteredTodos = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoListProvider);
  return todos;
});
final currentTodo = ScopedProvider<Todo>(null);

class HomePage extends HookWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = useProvider(filteredTodos);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          c.Title(),
          TextField(
            controller: null,
            decoration: const InputDecoration(
              labelText: 'What needs to be done?',
            ),
            onSubmitted: null
          ),
          const SizedBox(height: 42),
          const Toolbar(),
          const Divider(height: 0),
          for (var i = 0; i < todos.length; i++) ...[
            if (i > 0) const Divider(height: 0),
            Dismissible(
              key: ValueKey(todos[i].id),
              onDismissed: null,
              child: ProviderScope(
                overrides: [
                  currentTodo.overrideWithValue(todos[i]),
                ],
                child: const TodoItem(),
              ),
            )
          ],
        ],
      ),
    );
  }
}