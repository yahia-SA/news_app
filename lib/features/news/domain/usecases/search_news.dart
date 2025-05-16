import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';

class SearchNewsUseCase {
  final NewsRepository repository;

  SearchNewsUseCase(this.repository);

  Future<List<Article>> execute(String query) async {
      final result = await repository.getNewsByQuery(query);
      return result;
    }
  }
