import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lilinet_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:lilinet_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:lilinet_app/features/auth/presentation/widgets/auth_dialog.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class FakeAuthSubmitted extends Fake implements AuthSubmitted {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUpAll(() {
    registerFallbackValue(FakeAuthSubmitted());
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (_) => mockAuthBloc,
        child: const Scaffold(body: AuthDialog()),
      ),
    );
  }

  testWidgets('renders correctly and toggles password visibility', (
    tester,
  ) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final passwordFieldFinder = find.widgetWithText(TextFormField, 'Password');
    expect(passwordFieldFinder, findsOneWidget);

    final textFieldFinder = find.descendant(
      of: passwordFieldFinder,
      matching: find.byType(TextField),
    );
    final textField = tester.widget<TextField>(textFieldFinder);
    expect(textField.obscureText, isTrue);

    final visibilityIconFinder = find.byIcon(Icons.visibility);
    await tester.tap(visibilityIconFinder);
    await tester.pump();

    final textFieldToggled = tester.widget<TextField>(textFieldFinder);
    expect(textFieldToggled.obscureText, isFalse);
  });

  testWidgets('validates password length only in Sign Up mode', (tester) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Default is Login mode. Enter short password.
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      '123456',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'user123',
    );

    // Tap Login
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pump();

    // Expect NO validation error for length
    expect(find.text('Password must be at least 8 characters'), findsNothing);

    // Switch to Sign Up mode
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    // Tap Sign Up
    await tester.tap(find.widgetWithText(FilledButton, 'Sign Up'));
    await tester.pump();

    // Expect validation error
    expect(find.text('Password must be at least 8 characters'), findsOneWidget);
  });

  testWidgets('enforces username input formatters and max length', (
    tester,
  ) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final usernameFieldFinder = find.widgetWithText(TextFormField, 'Username');
    expect(usernameFieldFinder, findsOneWidget);

    final textFieldFinder = find.descendant(
      of: usernameFieldFinder,
      matching: find.byType(TextField),
    );
    final textField = tester.widget<TextField>(textFieldFinder);

    // Check maxLength
    expect(textField.maxLength, 30);

    // Check input formatters
    expect(textField.inputFormatters, isNotEmpty);
    expect(
      textField.inputFormatters!.first,
      isA<FilteringTextInputFormatter>(),
    );
  });

  testWidgets('dispatches AuthSubmitted with isLogin=true in Login mode', (
    tester,
  ) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'user123',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password123',
    );

    // Tap Login button
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pump();

    verify(
      () => mockAuthBloc.add(
        const AuthSubmitted(
          username: 'user123',
          password: 'password123',
          isLogin: true,
        ),
      ),
    ).called(1);
  });

  testWidgets('dispatches AuthSubmitted with isLogin=false in Sign Up mode', (
    tester,
  ) async {
    when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Switch to Sign Up
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'newuser',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password123',
    ); // > 8 chars

    // Tap Sign Up button
    await tester.tap(find.widgetWithText(FilledButton, 'Sign Up'));
    await tester.pump();

    verify(
      () => mockAuthBloc.add(
        const AuthSubmitted(
          username: 'newuser',
          password: 'password123',
          isLogin: false,
        ),
      ),
    ).called(1);
  });
}
