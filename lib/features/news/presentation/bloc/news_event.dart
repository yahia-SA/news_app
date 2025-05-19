part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();
  @override
  List<Object?> get props => [];
}

class SearchNews extends NewsEvent {
  final String query;
  const SearchNews(this.query);

  @override
  List<Object?> get props => [query];
}

class GetSavedArticles extends NewsEvent {}

class GetAllNews extends NewsEvent {}
// Bookmark Events
class AddBookmark extends NewsEvent {
  final ArticleModel article;

  const AddBookmark(this.article);

  @override
  List<Object?> get props => [article];
}

class RemoveBookmark extends NewsEvent {
  final String title;

  const RemoveBookmark(this.title);

  @override
  List<Object?> get props => [title];
}

class CheckBookmarkStatus extends NewsEvent {
  final String title;

  const CheckBookmarkStatus(this.title);

  @override
  List<Object?> get props => [title];
}
