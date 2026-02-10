# Feature Audit Summary

This report reviews the primary feature modules to highlight current behavior,
dependencies, and known risks or follow-ups to validate.

## Auth
- **Status:** Supabase-backed auth with `AuthBloc` handling login, logout, and
  state transitions. Auth state updates trigger favorite reloads in `MyApp`.
- **Risks/Follow-ups:** Ensure dialogs (password reset/change/update profile)
  handle `AuthLoading` transitions without flicker and keep the UI responsive
  when auth state re-emits `Authenticated`.

## Comments
- **Status:** `CommentCubit` loads comments, manages realtime updates, and
  supports likes/replies with optimistic updates.
- **Risks/Follow-ups:** Comments load relies on a non-null `mediaId`. When player
  state is incomplete, comments should be hidden or deferred to prevent loading
  a placeholder thread.

## Downloads
- **Status:** Downloads page uses `DownloadService` to list items and triggers
  playback by dispatching `PlayVideo` followed by a `LoadVideo` for the local
  file path.
- **Risks/Follow-ups:** Validate local playback flow when `mediaId` is missing
  (downloads use file metadata) and ensure offline playback does not conflict
  with streaming state.

## Explore
- **Status:** Explore page drives discovery via `ExploreBloc` with category chips
  and loads genres/movies into grid views with padding that accounts for the
  miniplayer.
- **Risks/Follow-ups:** Refresh logic depends on `_selectedCategory` strings;
  consider centralizing the mapping to reduce drift as categories evolve.

## Favorites
- **Status:** Favorites rely on `FavoritesBloc` with optimistic add/remove and
  pagination.
- **Risks/Follow-ups:** Review pagination limits and how favorites are reloaded
  on auth changes to ensure state remains consistent across sessions.

## History
- **Status:** `HistoryCubit` loads progress, saves updates optimistically, and
  caps in-memory history to 100 items.
- **Risks/Follow-ups:** Confirm history reload triggers in `_loadBackgroundData`
  and ensure history state is refreshed after playback events.

## Main
- **Status:** `ScaffoldWithPlayer` coordinates navigation + miniplayer overlay.
- **Risks/Follow-ups:** Nav bar visibility toggles are route-based; verify edge
  cases when switching between detail routes and tab navigation.

## Movies
- **Status:** Movie details load via `MovieDetailsBloc` and dispatch `PlayVideo`
  with metadata for the player. Episodes are filtered for future release dates.
- **Risks/Follow-ups:** Ensure `mediaType` normalization for playback and
  auto-play logic; confirm play actions run only when data is available.

## Settings
- **Status:** Settings view uses sections for account, appearance, playback,
  content, storage, and about. Dialogs reset cache/settings and operate above
  the miniplayer.
- **Risks/Follow-ups:** Confirm destructive actions (clear cache/delete account)
  are guarded consistently and localized.

## Video Player
- **Status:** Video playback is orchestrated by `VideoPlayerBloc` and a
  `VideoPlayerService`. `VideoPlayerContent` handles playback, offline state,
  streaming link selection, and progress persistence.
- **Risks/Follow-ups:** Ensure comments render only when `mediaId` is ready and
  that restored sessions do not trigger unexpected replays.
