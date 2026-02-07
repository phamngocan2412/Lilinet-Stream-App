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
  late Box<LocalCommentModel> _box;

  LocalCommentDataSourceImpl() {
    _initBox();
  }

  Future<void> _initBox() async {
    _box = await Hive.openBox<LocalCommentModel>(_boxName);
  }

  @override
  Future<List<LocalCommentModel>> getCommentsForVideo(String videoId) async {
    await _ensureBoxOpen();
    return _box.values.where((comment) => comment.videoId == videoId).toList();
  }

  @override
  Future<List<LocalCommentModel>> getAllPendingComments() async {
    await _ensureBoxOpen();
    return _box.values
        .where((comment) => !comment.isSynced && !comment.isGuest)
        .toList();
  }

  @override
  Future<List<LocalCommentModel>> getAllGuestComments() async {
    await _ensureBoxOpen();
    return _box.values.where((comment) => comment.isGuest).toList();
  }

  @override
  Future<void> saveComment(LocalCommentModel comment) async {
    await _ensureBoxOpen();
    await _box.put(comment.localId, comment);
  }

  @override
  Future<void> updateComment(LocalCommentModel comment) async {
    await _ensureBoxOpen();
    await _box.put(comment.localId, comment);
  }

  @override
  Future<void> deleteComment(String localId) async {
    await _ensureBoxOpen();
    await _box.delete(localId);
  }

  @override
  Future<void> markAsSynced(String localId, String serverId) async {
    await _ensureBoxOpen();
    final comment = _box.get(localId);
    if (comment != null) {
      final updated = comment.markAsSynced(serverId);
      await _box.put(localId, updated);
    }
  }

  @override
  Future<void> clearSyncedComments() async {
    await _ensureBoxOpen();
    final syncedComments = _box.values.where((c) => c.isSynced).toList();
    for (final comment in syncedComments) {
      await _box.delete(comment.localId);
    }
  }

  @override
  Future<LocalCommentModel?> getCommentById(String localId) async {
    await _ensureBoxOpen();
    return _box.get(localId);
  }

  Future<void> _ensureBoxOpen() async {
    if (!_box.isOpen) {
      await _initBox();
    }
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
