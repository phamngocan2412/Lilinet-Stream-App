import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/features/comments/presentation/widgets/comment_input.dart';

void main() {
  testWidgets('CommentInput has maxLength limit to prevent DoS',
      (tester) async {
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

    await tester.pumpAndSettle();

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    final textField = tester.widget<TextField>(textFieldFinder);

    // Check maxLength - initially this will fail as it is null
    expect(textField.maxLength, 1000,
        reason: 'TextField should have maxLength set to 1000 to prevent DoS');
  });
}
