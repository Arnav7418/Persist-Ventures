class Post {
  final int id;
  final String title;
  final String videoLink;
  final String thumbnailUrl;
  final String username;
  final String pictureUrl;
  final int upvoteCount;
  final int viewCount;
  final bool upvoted;
  final bool bookmarked;

  Post({
    required this.id,
    required this.title,
    required this.videoLink,
    required this.thumbnailUrl,
    required this.username,
    required this.pictureUrl,
    required this.upvoteCount,
    required this.viewCount,
    required this.upvoted,
    required this.bookmarked,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      videoLink: json['video_link'],
      thumbnailUrl: json['thumbnail_url'],
      username: json['username'],
      pictureUrl: json['picture_url'],
      upvoteCount: json['upvote_count'],
      viewCount: json['view_count'],
      upvoted: json['upvoted'],
      bookmarked: json['bookmarked'],
    );
  }
}