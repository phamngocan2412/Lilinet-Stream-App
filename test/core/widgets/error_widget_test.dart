import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/core/widgets/error_widget.dart';

void main() {
  testWidgets('AppErrorWidget shows raw message in debug mode', (WidgetTester tester) async {
    const rawMessage = 'Critical Database Failure: Stack Trace...';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppErrorWidget(message: rawMessage),
        ),
      ),
    );

    // Verify the raw message is displayed
    expect(find.text(rawMessage), findsOneWidget);
  });
}
