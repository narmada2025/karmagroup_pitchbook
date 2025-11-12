class Video {
  final String title;
  final String videoId;
  final String thumbnailUrl;

  Video(
      {required this.title, required this.videoId, required this.thumbnailUrl});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['snippet']['title'],
      videoId: json['snippet']['resourceId']['videoId'],
      thumbnailUrl: json['snippet']['thumbnails']['default']['url'],
    );
  }
}
