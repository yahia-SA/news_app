import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/constants/app_constants.dart';
import 'package:news_app/core/routing/app_router.dart';
import 'package:news_app/core/routing/navigator_services.dart';
import 'package:news_app/core/routing/routes.dart';
import 'package:news_app/core/services/locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables
  await dotenv.load();
  await Hive.initFlutter();
  await EasyLocalization.ensureInitialized();

  // Register Hive Adapter
  Hive.registerAdapter(ArticleModelAdapter());

  // Open Hive Box
  await Hive.openBox<ArticleModel>('bookmarks');

  // Setup GetIt Service Locator
  setupLocator();

  runApp(
    EasyLocalization(
      supportedLocales: AppConstants.supportedLocales,
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: MainApp(appRouter: AppRouter()),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            initialRoute: Routes.bottomnav,
            onGenerateRoute: appRouter.onGenerateRoute,
          ),
    );
  }
}
