import 'package:equatable/equatable.dart';

class TaskResponse extends Equatable{
  const TaskResponse({
    required this.id,
    required this.slug,
    required this.url,
    required this.title,
    required this.content,
    required this.image,
    required this.thumbnail,
    required this.status,
    required this.category,
    required this.publishedAt,
    required this.updatedAt,
    required this.userId,
  });

  factory TaskResponse.fromMap(Map<String, dynamic> json) => TaskResponse(
        id: json['id'] as int? ?? 0,
        slug: json['slug'] as String? ?? '',
        url: json['url'] as String? ?? '',
        title: json['title'] as String? ?? '',
        content: json['content'] as String? ?? '',
        image: json['image'] as String? ?? '',
        thumbnail: json['thumbnail'] as String? ?? '',
        status: json['status'] as String? ?? '',
        category: json['category'] as String? ?? '',
        publishedAt: json['publishedAt'] as String? ?? '',
        updatedAt: json['updatedAt'] as String? ?? '',
        userId: json['userId'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'slug': slug,
        'url': url,
        'title': title,
        'content': content,
        'image': image,
        'thumbnail': thumbnail,
        'status': status,
        'category': category,
        'publishedAt': publishedAt,
        'updatedAt': updatedAt,
        'userId': userId,
      };

  final int id;
  final String slug;
  final String url;
  final String title;
  final String content;
  final String image;
  final String thumbnail;
  final String status;
  final String category;
  final String publishedAt;
  final String updatedAt;
  final int userId;

  @override
  List<Object?> get props => [
        id,
        slug,
        url,
        title,
        content,
        image,
        thumbnail,
        status,
        category,
        publishedAt,
        updatedAt,
        userId,
      ];
}
