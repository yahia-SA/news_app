import 'package:hive/hive.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

class LocalDataSource {
  final Box<ArticleModel> box = Hive.box<ArticleModel>('bookmarks');

  Future<void> saveArticle(ArticleModel article) async {
    await box.put(article.title, article);
  }

  List<ArticleModel> getSavedArticles() {
    return box.values.toList();
  }

  Future<void> deleteArticle(String title) async {
    await box.delete(title);
  }
}