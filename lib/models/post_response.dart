import 'package:equatable/equatable.dart';

class PostResponse with EquatableMixin {
  final int userId;
  final int id;
  final String title;
  final String body;

  const PostResponse(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );

  @override
  List<Object?> get props => [userId, id, title, body];
}
