import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news_test_app/src/presentation/pages/main_news_page.dart';
import 'package:news_test_app/src/presentation/pages/refresh_news_page.dart';
import '../../domain/models/article.dart';
import '../../presentation/pages/article_details_page.dart';
import '../../presentation/pages/timer_news_page.dart';
import '../../presentation/pages/saved_articles_page.dart';

part 'app_router.gr.dart';

@AdaptiveAutoRouter(
  routes: [
    AutoRoute(page: MainNewsPage, initial: true),
    AutoRoute(page: BreakingNewsWithRefresh),
    AutoRoute(page: BreakingNewsWithTimer),
    AutoRoute(page: ArticleDetailsPage),
    AutoRoute(page: SavedArticlesPage),
  ],
)
class AppRouter extends _$AppRouter {}

final appRouter = AppRouter();
