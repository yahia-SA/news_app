// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';

import '../../domain/entities/article_entity.dart';
part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel extends Article {
  @override
  @HiveField(0)
  final String title;

  @override
  @HiveField(1)
  final String? description;

  @override
  @HiveField(2)
  final String url;

  @override
  @HiveField(3)
  final String urlToImage;

  @override
  @HiveField(4)
  final String publishedAt;

  @override
  @HiveField(5)
  final String? sourceName;

  @override
  @HiveField(6)
  final String? author;

  ArticleModel({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.sourceName,
    required this.author,
  }) : super(
         title: title,
         description: description,
         url: url,
         urlToImage: urlToImage,
         publishedAt: publishedAt,
         sourceName: sourceName,
         author: author,
       );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'] ??'',
      publishedAt: json['publishedAt'],
      sourceName: json['source']?['name'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'source': {'name': sourceName},
      'author': author,
    };
  }
}
