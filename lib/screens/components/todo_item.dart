import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../home_page.dart';

class TodoItem extends HookWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = useProvider(currentTodo);
    return Material(
      color: Colors.white,
      elevation: 6,
      child: ListTile(
        onTap: null,
        leading: Checkbox(
          value: todo.completed,
          onChanged: null,
        ),
        title: Text(todo.description)
      ),
    );
  }
}