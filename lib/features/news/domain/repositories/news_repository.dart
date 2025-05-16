import 'package:news_app/features/news/domain/entities/article_entity.dart';

abstract class NewsRepository {
  Future<List<Article>> getNewsByQuery(String query);
  Future<List<Article>> getAllNews();
}