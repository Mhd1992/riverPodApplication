class PostEntity {
  final String userId;
  final String id;
  final String title;
  final String body;

  PostEntity({required this.userId, required this.id, required this.title, required this.body});

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
        userId: json['userId'].toString(),
        id: json['id'].toString(),
        title: json['title'],
        body: json['body']);
  }


  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body
    };
  }

}
