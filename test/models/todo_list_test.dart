import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/models/todo.dart';
import 'package:riverpod_todo/models/todo_list.dart';

StateNotifierProvider<TodoList, List<Todo>> createNotifier(List<Todo> list) {
  return StateNotifierProvider<TodoList, List<Todo>>(
    (ref) => TodoList(list)
  );
}

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
  test('read provider', () {
    final container = ProviderContainer();
    final list = container.read(createNotifier([
      uncompleted,
      completed
    ]));
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
    final provider = createNotifier([
      uncompleted,
      completed
    ]);
    final notifier = container.read(provider.notifier);
    var description = "NEW DESCRIPTION";
    notifier.add(description);
    final list = container.read(provider);
    expect(list.length, 3);
    expect(list[2].description, description);
    expect(list[2].completed, false);
  });

  test('TodoList#toggle', () {
    final container = ProviderContainer();
    final provider = createNotifier([uncompleted]);

    final beforeList = container.read(provider);
    expect(beforeList[0].completed, false);

    container.read(provider.notifier).toggle(uncompleted.id);

    final afterList = container.read(provider);
    expect(afterList[0].completed, true);
  });

  test('TodoList#edit', () {
    final container = ProviderContainer();
    final provider = createNotifier([uncompleted]);

    final editDescription = "EDIT Description";
    container.read(provider.notifier).edit(
      id: uncompleted.id,
      description: editDescription
    );

    final list = container.read(provider);
    expect(list[0].description, editDescription);
  });

  test('TodoList#remove', () {
    final container = ProviderContainer();
    final provider = createNotifier([
      uncompleted,
      completed
    ]);
    final notifier = container.read(provider.notifier);

    notifier.remove(uncompleted);
    final firstList = container.read(provider);
    expect(firstList.length, 1);
    expect(firstList[0].description, completed.description);

    notifier.remove(completed);
    final secondList = container.read(provider);
    expect(secondList.length, 0);
  });
}