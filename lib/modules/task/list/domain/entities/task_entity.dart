import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable{
  const TaskEntity({
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

  const TaskEntity.empty() :
    id= 0,
    slug= '',
    url= '',
    title= '',
    content= '',
    image= '',
    thumbnail= '',
    status= '',
    category= '',
    publishedAt= '',
    updatedAt= '',
    userId= 0;

  factory TaskEntity.fromMap(Map<String, dynamic> json) => TaskEntity(
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
  
  //copywith
  TaskEntity copyWith({
    int? id,
    String? slug,
    String? url,
    String? title,
    String? content,
    String? image,
    String? thumbnail,
    String? status,
    String? category,
    String? publishedAt,
    String? updatedAt,
    int? userId,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      url: url ?? this.url,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      thumbnail: thumbnail ?? this.thumbnail,
      status: status ?? this.status,
      category: category ?? this.category,
      publishedAt: publishedAt ?? this.publishedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

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
