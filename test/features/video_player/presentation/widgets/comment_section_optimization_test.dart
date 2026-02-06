import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import 'package:lilinet_app/features/video_player/presentation/bloc/comments/comments_cubit.dart';
import 'package:lilinet_app/features/video_player/presentation/bloc/comments/comments_state.dart';
import 'package:lilinet_app/features/video_player/presentation/widgets/comment_section.dart';
import 'package:lilinet_app/core/widgets/cached_image.dart';

class MockCommentsCubit extends MockCubit<CommentsState>
    implements CommentsCubit {}

void main() {
  late MockCommentsCubit mockCommentsCubit;

  setUp(() {
    mockCommentsCubit = MockCommentsCubit();
    if (!GetIt.I.isRegistered<CommentsCubit>()) {
      GetIt.I.registerSingleton<CommentsCubit>(mockCommentsCubit);
    }
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('CommentSection uses AppCachedImage (optimized)', (tester) async {
    final comments = [
      CommentModel(
        id: '1',
        userName: 'User 1',
        userAvatarUrl: 'https://example.com/avatar1.jpg',
        content: 'Test comment',
        createdAt: DateTime.now(),
      ),
    ];

    when(() => mockCommentsCubit.state)
        .thenReturn(CommentsLoaded('123', comments));
    when(() => mockCommentsCubit.loadComments(any())).thenAnswer((_) async {});
    when(() => mockCommentsCubit.close()).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommentSection(videoId: '123'),
        ),
      ),
    );

    await tester.pump(); // Trigger BlocBuilder

    // Verify AppCachedImage is present in ListView
    final imageFinder = find.descendant(
      of: find.byType(ListView),
      matching: find.byType(AppCachedImage),
    );

    expect(imageFinder, findsOneWidget);

    final appCachedImage = tester.widget<AppCachedImage>(imageFinder.first);
    expect(appCachedImage.width, 36);
    expect(appCachedImage.height, 36);

    // Verify CircleAvatar is NOT present in ListView (because we replaced it for users with avatar)
    final avatarFinder = find.descendant(
      of: find.byType(ListView),
      matching: find.byType(CircleAvatar),
    );

    expect(avatarFinder, findsNothing);
  });
}
