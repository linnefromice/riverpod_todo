import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_todo/models/todo.dart';
import 'package:riverpod_todo/screens/components/title.dart' as c;

void main() {
  test('todo model has attributes', () {
    final todo = Todo(id: "1", description: "description");
    expect(todo.id, "1");
    expect(todo.description, "description");
  });
}