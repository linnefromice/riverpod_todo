import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.white,
      elevation: 6,
      child: ListTile(
        onTap: null,
        leading: Checkbox(
          value: true,
          onChanged: null,
        ),
        title: Text("todo.description")
      ),
    );
  }
}