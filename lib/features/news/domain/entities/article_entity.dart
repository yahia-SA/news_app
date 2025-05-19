// ignore_for_file: public_member_api_docs, sort_constructors_first
class Article {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? sourceName;
  final String? author;
   bool isBookmarked;

   Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.sourceName,
    required this.author,
    this.isBookmarked = false,
  });

  Article copyWith({
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? sourceName,
    String? author,
    bool? isBookmarked,
  }) {
    return Article(
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      sourceName: sourceName ?? this.sourceName,
      author: author ?? this.author,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
