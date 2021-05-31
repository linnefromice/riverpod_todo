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
enum TodoListFilter {
  all,
  active,
  completed,
}
final todoListFilter = StateProvider((_) => TodoListFilter.all);
final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);
  switch (filter.state) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
    default:
      return todos;
  }
});
final currentTodo = ScopedProvider<Todo>(null);

final addTodoKey = UniqueKey();

class HomePage extends HookWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = useProvider(filteredTodos);
    final newTodoController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            c.Title(),
            TextField(
              key: addTodoKey,
              controller: newTodoController,
              decoration: const InputDecoration(
                labelText: 'What needs to be done?',
              ),
              onSubmitted: (value) {
                context.read(todoListProvider.notifier).add(value);
                newTodoController.clear();
              },
            ),
            const SizedBox(height: 42),
            const Toolbar(),
            const Divider(height: 0),
            for (var i = 0; i < todos.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              Dismissible(
                key: ValueKey(todos[i].id),
                onDismissed: (_) {
                  context.read(todoListProvider.notifier).remove(todos[i]);
                },
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
      ),
    );
  }
}