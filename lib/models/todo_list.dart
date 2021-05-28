import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'todo.dart';

const _uuid = Uuid();

class TodoList extends StateNotifier<List<Todo>> {
  // こっちでnullチェック吸収すべき？
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  void add(String description) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            description: description,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>(
  (ref) => TodoList([
    Todo(id: 'todo-0', description: 'hi', completed: true),
    Todo(id: 'todo-1', description: 'hello'),
    Todo(id: 'todo-2', description: 'bonjour'),
  ]
));
