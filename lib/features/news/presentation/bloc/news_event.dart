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

class GetAllNews extends NewsEvent {
  const GetAllNews();
  @override
  List<Object?> get props => [];
}