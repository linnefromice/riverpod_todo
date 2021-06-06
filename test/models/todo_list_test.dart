import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/models/todo.dart';
import 'package:riverpod_todo/models/todo_list.dart';

void main() {
  var uncompleted = Todo(
    id: 'id_uncompleted',
    description: 'description_uncompleted'
  );
  var completed = Todo(
    id: 'id_completed',
    description: 'description_completed',
    completed: true
  );
  final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>(
    (ref) => TodoList([
      uncompleted,
      completed
    ]
  ));
  test('read provider', () {
    final container = ProviderContainer();
    final list = container.read(todoListProvider);
    expect(list.length, 2);
    expect(list[0].id, uncompleted.id);
    expect(list[0].description, uncompleted.description);
    expect(list[0].completed, uncompleted.completed);
    expect(list[1].id, completed.id);
    expect(list[1].description, completed.description);
    expect(list[1].completed, completed.completed);
  });

  test('TodoList#add', () {
    final container = ProviderContainer();
    final notifier = container.read(todoListProvider.notifier);
    var description = "NEW DESCRIPTION";
    notifier.add(description);
    final list = container.read(todoListProvider);
    expect(list.length, 3);
    expect(list[2].description, description);
    expect(list[2].completed, false);
  });

  test('TodoList#remove', () {
    final container = ProviderContainer();
    final notifier = container.read(todoListProvider.notifier);

    notifier.remove(uncompleted);
    final firstList = container.read(todoListProvider);
    expect(firstList.length, 1);
    expect(firstList[0].description, completed.description);

    notifier.remove(completed);
    final secondList = container.read(todoListProvider);
    expect(secondList.length, 0);
  });
}