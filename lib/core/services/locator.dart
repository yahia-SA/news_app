import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/netwrok/api_consumer.dart';
import 'package:news_app/core/netwrok/dio_consumer.dart';
import 'package:news_app/features/news/data/datasources/local_data_source.dart';
import 'package:news_app/features/news/data/datasources/remote_data_source.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/usecases/get_all_news_usecase.dart';
import 'package:news_app/features/news/domain/usecases/search_news.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Initialize Hive first
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleModelAdapter());
  // Open Hive Box
  await Hive.openBox<ArticleModel>('bookmarks');

  // Core
  locator.registerLazySingleton(() => Dio());

  // ApiConsumer
  locator.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(client: locator()),
  );

  // Data Sources
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSource(apiConsumer: locator()),
  );

  // Local Data Source - use registerSingletonAsync
  locator.registerSingletonAsync<LocalDataSource>(() async {
    final box = await Hive.openBox<ArticleModel>('bookmarks');
    return LocalDataSource(box);
  });

  // Wait for async registrations to complete
  await locator.allReady();

  // Repository
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(locator()),
  );

  // Use Cases
  locator.registerLazySingleton(() => SearchNewsUseCase(locator()));
  locator.registerLazySingleton(() => GetAllNewsUseCase(locator()));

  // Bloc
  locator.registerFactory(
    () => NewsBloc(
      searchNewsUseCase: locator(),
      getAllNewsUseCase: locator(),
      localDataSource: locator(),
    ),
  );
}
