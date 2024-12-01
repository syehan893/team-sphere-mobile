import 'package:equatable/equatable.dart';

class News extends Equatable {
  final int? newsId;
  final String? title;
  final String? content;
  final String? publicationDate;
  final String? category;
  final String? importance;
  final String? attachmentUrl;
  final bool? isPublished;
  final String? createdAt;
  final String? updatedAt;
  final String? authorId;

  const News(
      {this.newsId,
      this.title,
      this.content,
      this.publicationDate,
      this.category,
      this.importance,
      this.attachmentUrl,
      this.isPublished,
      this.createdAt,
      this.updatedAt,
      this.authorId});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      newsId: json['news_id'],
      title: json['title'],
      content: json['content'],
      publicationDate: json['publication_date'],
      category: json['category'],
      importance: json['importance'],
      attachmentUrl: json['attachment_url'],
      isPublished: json['is_published'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      authorId: json['author_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['news_id'] = newsId;
    data['title'] = title;
    data['content'] = content;
    data['publication_date'] = publicationDate;
    data['category'] = category;
    data['importance'] = importance;
    data['attachment_url'] = attachmentUrl;
    data['is_published'] = isPublished;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['author_id'] = authorId;
    return data;
  }

  @override
  List<Object?> get props {
    return [
      newsId,
      title,
      content,
      publicationDate,
      category,
      importance,
      attachmentUrl,
      isPublished,
      createdAt,
      updatedAt,
      authorId,
    ];
  }
}
