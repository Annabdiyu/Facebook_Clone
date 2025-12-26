class User {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final int friendsCount;
  final List<String> mutualFriends;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.friendsCount,
    required this.mutualFriends,
  });
}

class Post {
  final String id;
  final User user;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;
  final int likes;
  final int comments;
  final bool isLiked;

  Post({
    required this.id,
    required this.user,
    required this.content,
    this.imageUrl,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.isLiked,
  });
}

class Story {
  final String id;
  final User user;
  final String? imageUrl;
  final bool isViewed;

  Story({
    required this.id,
    required this.user,
    this.imageUrl,
    required this.isViewed,
  });
}