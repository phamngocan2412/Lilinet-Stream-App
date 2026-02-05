import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/features/comments/presentation/widgets/comment_input.dart';

void main() {
  testWidgets('CommentInput has maxLength set to 1000', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommentInput(
            onSend: (_) {},
            isLoggedIn: true,
          ),
        ),
      ),
    );

    // Find the TextField
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    // Verify maxLength properties
    final textField = tester.widget<TextField>(textFieldFinder);
    expect(textField.maxLength, 1000, reason: 'TextField should have maxLength of 1000');
    expect(textField.decoration?.counterText, '', reason: 'TextField should hide counter text');
  });
}
