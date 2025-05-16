import 'package:news_app/core/netwrok/api_consumer.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';

class RemoteDataSource {
  final ApiConsumer apiConsumer;
  RemoteDataSource({required this.apiConsumer});

  Future<List<Article>> fetchNewsByQuery(String query) async {
    final response = await apiConsumer.get(
      'everything',
      queryParameters: {
        'q': query,
      }
        );

    return (response['articles'] as List)
        .map((item) => ArticleModel.fromJson(item))
        .toList();
  }

  Future<List<Article>> fetchAllNews() async {
    final response = await apiConsumer.get(
      'everything',
      queryParameters: {
        'q' : 'latest',
      },
    );
    return (response['articles'] as List)
        .map((item) => ArticleModel.fromJson(item))
        .toList();
  }
}