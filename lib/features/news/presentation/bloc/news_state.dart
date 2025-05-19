part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  final List<String> bookmarkedArticles; // Track bookmarked titles

  const NewsLoaded({required this.articles, required this.bookmarkedArticles,});
  @override
  List<Object> get props => [articles, bookmarkedArticles,];

  NewsLoaded copyWith({
    List<Article>? articles,
    List<String>? bookmarkedArticles,
  }) {
    return NewsLoaded(
      articles: articles ?? this.articles,
      bookmarkedArticles: bookmarkedArticles ?? this.bookmarkedArticles,
    );
  }
}

class NewsError extends NewsState {
  final String message;
  const NewsError({required this.message});
  @override
  List<Object> get props => [message];
}

// Bookmark States
class BookmarkAdded extends NewsState {
  final Article article;
  const BookmarkAdded(this.article);

  @override
  List<Object> get props => [article];
}

class BookmarkRemoved extends NewsState {
  final String title;
  const BookmarkRemoved(this.title);

  @override
  List<Object> get props => [title];
}

class BookmarkStatusChecked extends NewsState {
  final bool isBookmarked;

  const BookmarkStatusChecked(this.isBookmarked);

  @override
  List<Object> get props => [isBookmarked];
}