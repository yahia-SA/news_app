
import 'package:hive/hive.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

class LocalDataSource {
  final Box<ArticleModel> box;

  LocalDataSource(this.box);

  static Future<LocalDataSource> getInstance() async {
    if (!Hive.isBoxOpen('bookmarks')) {
      await Hive.openBox<ArticleModel>('bookmarks');
    }
    final box = Hive.box<ArticleModel>('bookmarks');
    return LocalDataSource(box);
  }

  Future<void> saveArticle(ArticleModel article) async {
    await box.put(article.title, article);
  }

  Future<List<ArticleModel>> getSavedArticles() async {
    return box.values.toList();
  }

  Future<bool> isArticleBookmarked(String title) async {
    return box.containsKey(title);
  }

  Future<void> deleteArticle(String title) async {
    await box.delete(title);
  }
}
