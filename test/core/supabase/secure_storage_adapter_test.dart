import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/core/supabase/secure_storage_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late SecureStorageAdapter adapter;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    adapter = SecureStorageAdapter(storage: mockStorage);
  });

  group('SecureStorageAdapter', () {
    test('hasAccessToken returns true if key exists', () async {
      when(
        () => mockStorage.containsKey(key: supabasePersistSessionKey),
      ).thenAnswer((_) async => true);

      final result = await adapter.hasAccessToken();

      expect(result, isTrue);
      verify(
        () => mockStorage.containsKey(key: supabasePersistSessionKey),
      ).called(1);
    });

    test('accessToken returns token if key exists', () async {
      const token = 'test_token';
      when(
        () => mockStorage.read(key: supabasePersistSessionKey),
      ).thenAnswer((_) async => token);

      final result = await adapter.accessToken();

      expect(result, equals(token));
      verify(() => mockStorage.read(key: supabasePersistSessionKey)).called(1);
    });

    test('persistSession writes token', () async {
      const sessionString = '{"access_token": "token"}';
      when(
        () => mockStorage.write(
          key: supabasePersistSessionKey,
          value: sessionString,
        ),
      ).thenAnswer((_) async {});

      await adapter.persistSession(sessionString);

      verify(
        () => mockStorage.write(
          key: supabasePersistSessionKey,
          value: sessionString,
        ),
      ).called(1);
    });

    test('removePersistedSession deletes token', () async {
      when(
        () => mockStorage.delete(key: supabasePersistSessionKey),
      ).thenAnswer((_) async {});

      await adapter.removePersistedSession();

      verify(
        () => mockStorage.delete(key: supabasePersistSessionKey),
      ).called(1);
    });
  });
}
