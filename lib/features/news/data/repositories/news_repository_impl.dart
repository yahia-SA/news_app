import 'package:news_app/features/news/data/datasources/remote_data_source.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';

class NewsRepositoryImpl implements NewsRepository {
  final RemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Article>> getNewsByQuery(String query) async {
    return await remoteDataSource.fetchNewsByQuery(query);
  }
  
  @override
  Future<List<Article>> getAllNews() async {
    return await remoteDataSource.fetchAllNews();
  }
}