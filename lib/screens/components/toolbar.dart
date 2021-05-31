import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../home_page.dart';

final allFilterKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();

class Toolbar extends HookWidget {
  const Toolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = useProvider(uncompletedTodosCount);
    final filter = useProvider(todoListFilter);

    Color? textColorFor(TodoListFilter value) {
      return filter.state == value ? Colors.blue : Colors.grey;
    }

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${count.toString()} items left',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Tooltip(
            key: allFilterKey,
            message: 'All todos',
            child: TextButton(
              onPressed: () => filter.state = TodoListFilter.all,
              style: TextButton.styleFrom(
                primary: textColorFor(TodoListFilter.all),
              ),
              child: const Text('All'),
            ),
          ),
          Tooltip(
            key: activeFilterKey,
            message: 'Only uncompleted todos',
            child: TextButton(
              onPressed: () => filter.state = TodoListFilter.active,
              style: TextButton.styleFrom(
                primary: textColorFor(TodoListFilter.active),
              ),
              child: const Text('Active'),
            ),
          ),
          Tooltip(
            key: completedFilterKey,
            message: 'Only completed todos',
            child: TextButton(
              onPressed: () => filter.state = TodoListFilter.completed,
              style: TextButton.styleFrom(
                primary: textColorFor(TodoListFilter.completed),
              ),
              child: const Text('Completed'),
            ),
          ),
        ],
      ),
    );
  }
}