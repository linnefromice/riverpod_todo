import 'package:flutter/material.dart';
import 'components/title.dart' as c;
import 'components/todo_item.dart';
import 'components/toolbar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
          for (var i = 0; i < 3; i++) ...[ // temp number
            if (i > 0) const Divider(height: 0),
            Dismissible(
              key: ValueKey(i),
              onDismissed: null,
              child: const TodoItem(),
            )
          ],
        ],
      ),
    );
  }
}