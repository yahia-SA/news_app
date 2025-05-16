import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';
import 'package:news_app/features/news/domain/usecases/get_all_news_usecase.dart';
import 'package:news_app/features/news/domain/usecases/search_news.dart';

part 'news_event.dart';
part 'news_state.dart';
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final SearchNewsUseCase searchNewsUseCase;
  final GetAllNewsUseCase getAllNewsUseCase;

  NewsBloc({required this.searchNewsUseCase, required this.getAllNewsUseCase}) : super(NewsInitial()) {
    on<SearchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final List<Article> articles = await searchNewsUseCase.execute(event.query);
        emit(NewsLoaded(articles: articles));
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });

    on<GetAllNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final List<Article> articles = await getAllNewsUseCase.execute();
        emit(NewsLoaded(articles: articles));
      } catch (e) {
        emit(NewsError(message: e.toString()));
        log('error', error: e.toString());
      }
    });
  }
}