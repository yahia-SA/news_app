import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/data/datasources/local_data_source.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';
import 'package:news_app/features/news/domain/usecases/get_all_news_usecase.dart';
import 'package:news_app/features/news/domain/usecases/search_news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final SearchNewsUseCase searchNewsUseCase;
  final GetAllNewsUseCase getAllNewsUseCase;
  final LocalDataSource localDataSource;

  NewsBloc({
    required this.searchNewsUseCase,
    required this.getAllNewsUseCase,
    required this.localDataSource,
  }) : super(NewsInitial()) {
    on<SearchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final List<Article> articles = await searchNewsUseCase.execute(
          event.query,
        );
        final bookmarkedTitles = await localDataSource.getSavedArticles();
        emit(
          NewsLoaded(
            articles: articles,
            bookmarkedArticles:  bookmarkedTitles.map((article) => article.title).toList(),
          ),
        );
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });

    on<GetAllNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final List<Article> articles = await getAllNewsUseCase.execute();
        final isBookmarked = await localDataSource.getSavedArticles();
        emit(NewsLoaded(articles: articles, bookmarkedArticles: isBookmarked.map((article) => article.title).toList(),));
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });
    // Handle AddBookmark event
    on<AddBookmark>((event, emit) async {
      try {
        // Save to local storage
        await localDataSource.saveArticle(event.article);
        // Fetch updated bookmarked articles
        final bookmarkedArticles = await localDataSource.getSavedArticles();

        // Update state
        if (state is NewsLoaded) {
          final currentState = state as NewsLoaded;
          emit(
            currentState.copyWith(
              bookmarkedArticles: bookmarkedArticles.map((article) => article.title).toList(),
            ),
          );
          } else {
            emit(BookmarkAdded(event.article));
        }
      } catch (e) {
        emit(NewsError(message: 'Failed to add bookmark: ${e.toString()}'));
      }
    });
    // Handle RemoveBookmark event
    on<RemoveBookmark>((event, emit) async {
      // Validate required fields
      if (event.title.isEmpty) {
        emit(NewsError(message: 'Cannot remove bookmark - invalid title'));
        return;
      }

      try {
        // Delete from local storage
        await localDataSource.deleteArticle(event.title);

        // Fetch updated bookmarked articles
        final bookmarkedArticles = await localDataSource.getSavedArticles();

        // Update state
        if (state is NewsLoaded) {
          final currentState = state as NewsLoaded;
          emit(
            currentState.copyWith(
              bookmarkedArticles: bookmarkedArticles.map((article) => article.title).toList(),
            ),
          );
          } else {
            emit(BookmarkRemoved(event.title));
        }
      } catch (e) {
        emit(NewsError(message: 'Failed to remove bookmark: ${e.toString()}'));
      }
    });
    // Handle CheckBookmarkStatus event
    on<CheckBookmarkStatus>((event, emit) async {
      try {
        final isBookmarked = await localDataSource.isArticleBookmarked(
          event.title,
        );
        emit(BookmarkStatusChecked(isBookmarked));
      } catch (e) {
        emit(NewsError(message: 'Failed to check bookmark status'));
      }
    });

    // Get Saved Articles
    on<GetSavedArticles>((event, emit) async {
      try {
        final savedbookmarks = await localDataSource.getSavedArticles();

        log('Fetched saved articles: $savedbookmarks');
       if (state is NewsLoaded) {
          final currentState = state as NewsLoaded;
          emit(
            currentState.copyWith(
              articles: savedbookmarks,
              bookmarkedArticles: savedbookmarks.map((article) => article.title).toList(),
            ),
          );
          }      } catch (e) {
        emit(NewsError(message: 'Failed to get saved articles'));
            log('Error fetching saved articles: ${e.toString()}');

      }
    });

  }
}
