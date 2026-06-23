import 'package:hive/hive.dart';

class StorageService {
  final Box reelsBox = Hive.box('reels');

  // Save like status
  Future<void> saveLikeStatus(
    int reelIndex,
    bool isLiked,
  ) async {
    await reelsBox.put(
      'isLiked_$reelIndex',
      isLiked,
    );
  }

  // Get like status
  bool getLikeStatus(int reelIndex) {
    return reelsBox.get(
      'isLiked_$reelIndex',
      defaultValue: false,
    );
  }

  // Save likes count
  Future<void> saveLikesCount(
    int reelIndex,
    int likes,
  ) async {
    await reelsBox.put(
      'likes_$reelIndex',
      likes,
    );
  }

  // Get likes count
  int getLikesCount(int reelIndex) {
    return reelsBox.get(
      'likes_$reelIndex',
      defaultValue: 0,
    );
  }

  // Save comments
  Future<void> saveComments(
    int reelIndex,
    List<String> comments,
  ) async {
    await reelsBox.put(
      'comments_$reelIndex',
      comments,
    );
  }

  // Get comments
  List<String> getComments(
    int reelIndex,
  ) {
    return List<String>.from(
      reelsBox.get(
        'comments_$reelIndex',
        defaultValue: [],
      ),
    );
  }
}