import 'package:news_app/features/news/domain/entities/article_entity.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class GetAllNewsUseCase {
  final NewsRepository repository;

  GetAllNewsUseCase(this.repository);

  Future<List<Article>> execute() async {
    return await repository.getAllNews();
  }
}