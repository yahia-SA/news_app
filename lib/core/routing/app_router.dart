import 'package:flutter/material.dart';
import 'package:news_app/core/routing/routes.dart';
import 'package:news_app/features/news/domain/entities/article_entity.dart';
import 'package:news_app/features/news/presentation/pages/bookmarks_page.dart';
import 'package:news_app/features/news/presentation/pages/home_page.dart';
import 'package:news_app/features/news/presentation/pages/news_page.dart';
import 'package:news_app/features/news/presentation/pages/search_page.dart';
import 'package:news_app/features/news/presentation/widgets/custom_bottom_nav.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.bottomnav:
        return _createRoute(const BottomNavigation());
        
      case Routes.news:
              final article = settings.arguments as Article;
        return _createRoute( NewsPage(article: article,));
        case Routes.home:
        return _createRoute(const HomePage());
        case Routes.search:
        return _createRoute(SearchPage());
        case Routes.bookmarks:
        return _createRoute(BookmarksPage());        
      default:
        return null;
    }
  }
}
  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }