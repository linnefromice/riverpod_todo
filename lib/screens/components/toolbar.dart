import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../home_page.dart';

class Toolbar extends HookWidget {
  const Toolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = useProvider(uncompletedTodosCount);

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
            message: 'All todos',
            child: TextButton(
              onPressed: null,
              child: const Text('All'),
            ),
          ),
          Tooltip(
            message: 'Only uncompleted todos',
            child: TextButton(
              onPressed: null,
              child: const Text('Active'),
            ),
          ),
          Tooltip(
            message: 'Only completed todos',
            child: TextButton(
              onPressed: null,
              child: const Text('Completed'),
            ),
          ),
        ],
      ),
    );
  }
}