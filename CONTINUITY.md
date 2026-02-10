# CONTINUITY.md

## Ledger Snapshot
- **Goal**: Fix comment system bugs (avatar loading, username fallback, reply threading, @mention highlighting, optimistic UI).
- **Now**: All code changes applied and verified with `flutter analyze` — 0 errors.
- **Next**: Manual testing on device/emulator.
- **Open Questions**: None.

## Success Criteria
- [x] Avatar loads via `CachedNetworkImage` with shimmer placeholder.
- [x] Username shows real name from Supabase auth, not "User".
- [x] Reply to nested comment targets root `parentId` thread.
- [x] `@mention` text highlighted in primary color via `MentionText`.
- [x] Optimistic UI: comment appears instantly with "sending" indicator.
- [x] `flutter analyze` passes with 0 errors.
- [ ] Manual verification on device/emulator.

## Progress State
- Done: All 7 files modified/created, build_runner regenerated freezed files, analysis clean.
- Now: Walkthrough created. Awaiting manual testing.
- Next: User tests on device/emulator.

## Key Decisions
1. Used `Supabase.instance.client.auth.currentUser` metadata as secondary source for username/avatar (avoids extra API call).
2. Reply-to-reply always targets `reply.parentId ?? reply.id` to keep flat thread structure (YouTube style).
3. Optimistic comment uses `isSending` flag on `Comment` entity, removed on server response or failure.
4. `MentionText` widget uses regex `@([\w.\-]+)` to parse and highlight mentions.
