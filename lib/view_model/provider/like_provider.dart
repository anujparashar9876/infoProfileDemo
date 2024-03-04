import 'package:flutter/material.dart';

class LikeProvider extends ChangeNotifier {
  Map<String, bool> _likedPosts = {};

  bool isLiked(String postId) {
  return _likedPosts.containsKey(postId) ? _likedPosts[postId] ?? false : false;
}

  void toggleLike(String postId) {
  if (_likedPosts.containsKey(postId)) {
    _likedPosts[postId] = _likedPosts[postId] != null ? !_likedPosts[postId]! : true;
  } else {
    _likedPosts[postId] = true;
  }
  notifyListeners();
}
}