import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:lilinet_app/core/errors/failures.dart';
import 'package:lilinet_app/features/auth/data/datasources/auth_supabase_datasource.dart';
import 'package:lilinet_app/features/auth/data/repositories/auth_repository_impl.dart';

class MockAuthSupabaseDataSource extends Mock
    implements AuthSupabaseDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthSupabaseDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAuthSupabaseDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tSensitiveError = 'Database connection failed: 192.168.1.5';
  const tGenericError = 'An unexpected error occurred';

  group('signInWithEmail', () {
    test(
      'should return sanitized Failure when a generic Exception occurs',
      () async {
        // Arrange
        when(
          () => mockDataSource.signInWithEmail(
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(Exception(tSensitiveError));

        // Act
        final result = await repository.signInWithEmail(
          email: tEmail,
          password: tPassword,
        );

        // Assert
        expect(
          result,
          equals(const Left(Failure.server(tGenericError))),
        );
      },
    );
  });

  group('signUpWithEmail', () {
    test(
      'should return sanitized Failure when a generic Exception occurs',
      () async {
        // Arrange
        when(
          () => mockDataSource.signUpWithEmail(
            email: tEmail,
            password: tPassword,
            displayName: any(named: 'displayName'),
          ),
        ).thenThrow(Exception(tSensitiveError));

        // Act
        final result = await repository.signUpWithEmail(
          email: tEmail,
          password: tPassword,
        );

        // Assert
        expect(
          result,
          equals(const Left(Failure.server(tGenericError))),
        );
      },
    );
  });

  group('signOut', () {
    test(
      'should return sanitized Failure when a generic Exception occurs',
      () async {
        // Arrange
        when(
          () => mockDataSource.signOut(),
        ).thenThrow(Exception(tSensitiveError));

        // Act
        final result = await repository.signOut();

        // Assert
        expect(
          result,
          equals(const Left(Failure.server(tGenericError))),
        );
      },
    );
  });

  group('sendPasswordResetEmail', () {
    test(
      'should return sanitized Failure when a generic Exception occurs',
      () async {
        // Arrange
        when(
          () => mockDataSource.sendPasswordResetEmail(any()),
        ).thenThrow(Exception(tSensitiveError));

        // Act
        final result = await repository.sendPasswordResetEmail(tEmail);

        // Assert
        expect(
          result,
          equals(const Left(Failure.server(tGenericError))),
        );
      },
    );
  });
}
