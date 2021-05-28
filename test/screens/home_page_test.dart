import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_todo/screens/components/title.dart' as c;
import 'package:riverpod_todo/screens/components/toolbar.dart';
import 'package:riverpod_todo/screens/home_page.dart';

void main() {
  testWidgets('', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomePage()
    ));
    expect(find.byType(c.Title), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(Toolbar), findsOneWidget);
  });
}