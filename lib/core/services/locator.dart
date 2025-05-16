import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/netwrok/api_consumer.dart';
import 'package:news_app/core/netwrok/dio_consumer.dart';
import 'package:news_app/features/news/data/datasources/local_data_source.dart';
import 'package:news_app/features/news/data/datasources/remote_data_source.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/usecases/get_all_news_usecase.dart';
import 'package:news_app/features/news/domain/usecases/search_news.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';

final GetIt locator = GetIt.instance;
final String apikey =dotenv.env['API_KEY'].toString();
void setupLocator() {
  // Core
  locator.registerLazySingleton(() => Dio());

  // ApiConsumer
  locator.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: locator()));
// Data Sources
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(apiConsumer:  locator(),apiKey:apikey)
  );
  locator.registerLazySingleton<LocalDataSource>(() => LocalDataSource());

  // Repository
  locator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
         locator(),
      ));

  // Use Cases
  locator.registerLazySingleton(() => SearchNewsUseCase( locator()));
  locator.registerFactory(() => GetAllNewsUseCase( locator()));

  // Bloc
  locator.registerFactory(() => NewsBloc(searchNewsUseCase: locator(), getAllNewsUseCase: locator()));
}