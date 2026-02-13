import 'dart:math';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../models/local_comment_model.dart';

abstract class LocalCommentDataSource {
  Future<List<LocalCommentModel>> getCommentsForVideo(String videoId);
  Future<List<LocalCommentModel>> getAllPendingComments();
  Future<List<LocalCommentModel>> getAllGuestComments();
  Future<void> saveComment(LocalCommentModel comment);
  Future<void> updateComment(LocalCommentModel comment);
  Future<void> deleteComment(String localId);
  Future<void> markAsSynced(String localId, String serverId);
  Future<void> clearSyncedComments();
  Future<LocalCommentModel?> getCommentById(String localId);
}

@LazySingleton(as: LocalCommentDataSource)
class LocalCommentDataSourceImpl implements LocalCommentDataSource {
  static const String _boxName = 'local_comments';
  Box<LocalCommentModel>? _box;
  Future<Box<LocalCommentModel>>? _boxFuture;

  LocalCommentDataSourceImpl() {
    _boxFuture = _initBox();
  }

  Future<Box<LocalCommentModel>> _initBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<LocalCommentModel>(_boxName);
    }
    return Hive.openBox<LocalCommentModel>(_boxName);
  }

  @override
  Future<List<LocalCommentModel>> getCommentsForVideo(String videoId) async {
    final box = await _ensureBoxOpen();
    return box.values.where((comment) => comment.videoId == videoId).toList();
  }

  @override
  Future<List<LocalCommentModel>> getAllPendingComments() async {
    final box = await _ensureBoxOpen();
    return box.values
        .where((comment) => !comment.isSynced && !comment.isGuest)
        .toList();
  }

  @override
  Future<List<LocalCommentModel>> getAllGuestComments() async {
    final box = await _ensureBoxOpen();
    return box.values.where((comment) => comment.isGuest).toList();
  }

  @override
  Future<void> saveComment(LocalCommentModel comment) async {
    final box = await _ensureBoxOpen();
    await box.put(comment.localId, comment);
  }

  @override
  Future<void> updateComment(LocalCommentModel comment) async {
    final box = await _ensureBoxOpen();
    await box.put(comment.localId, comment);
  }

  @override
  Future<void> deleteComment(String localId) async {
    final box = await _ensureBoxOpen();
    await box.delete(localId);
  }

  @override
  Future<void> markAsSynced(String localId, String serverId) async {
    final box = await _ensureBoxOpen();
    final comment = box.get(localId);
    if (comment != null) {
      final updated = comment.markAsSynced(serverId);
      await box.put(localId, updated);
    }
  }

  @override
  Future<void> clearSyncedComments() async {
    final box = await _ensureBoxOpen();
    final syncedComments = box.values.where((c) => c.isSynced).toList();
    for (final comment in syncedComments) {
      await box.delete(comment.localId);
    }
  }

  @override
  Future<LocalCommentModel?> getCommentById(String localId) async {
    final box = await _ensureBoxOpen();
    return box.get(localId);
  }

  Future<Box<LocalCommentModel>> _ensureBoxOpen() async {
    final currentBox = _box;
    if (currentBox != null && currentBox.isOpen) {
      return currentBox;
    }

    _boxFuture ??= _initBox();
    final opened = await _boxFuture!;
    _box = opened;

    if (!opened.isOpen) {
      _boxFuture = _initBox();
      _box = await _boxFuture!;
    }

    return _box!;
  }

  // Helper to generate unique local ID
  static String generateLocalId() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomPart = random.nextInt(999999).toString().padLeft(6, '0');
    return 'local_${timestamp}_$randomPart';
  }

  // Helper to generate guest username
  static String generateGuestName() {
    final random = Random();
    final number = random.nextInt(999999).toString().padLeft(6, '0');
    return 'Guest_$number';
  }
}
