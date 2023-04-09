// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MainNewsPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const MainNewsPage(),
      );
    },
    BreakingNewsWithRefreshRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const BreakingNewsWithRefresh(),
      );
    },
    BreakingNewsWithTimerRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const BreakingNewsWithTimer(),
      );
    },
    ArticleDetailsViewRoute.name: (routeData) {
      final args = routeData.argsAs<ArticleDetailsViewRouteArgs>();
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: ArticleDetailsPage(
          key: args.key,
          article: args.article,
        ),
      );
    },
    SavedArticlesPageRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
        routeData: routeData,
        child: const SavedArticlesPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          MainNewsPageRoute.name,
          path: '/',
        ),
        RouteConfig(
          BreakingNewsWithRefreshRoute.name,
          path: '/breaking-news-with-refresh',
        ),
        RouteConfig(
          BreakingNewsWithTimerRoute.name,
          path: '/breaking-news-with-timer',
        ),
        RouteConfig(
          ArticleDetailsViewRoute.name,
          path: '/article-details-view',
        ),
        RouteConfig(
          SavedArticlesPageRoute.name,
          path: '/saved-articles-page',
        ),
      ];
}

/// generated route for
/// [MainNewsPage]
class MainNewsPageRoute extends PageRouteInfo<void> {
  const MainNewsPageRoute()
      : super(
          MainNewsPageRoute.name,
          path: '/',
        );

  static const String name = 'MainNewsPageRoute';
}

/// generated route for
/// [BreakingNewsWithRefresh]
class BreakingNewsWithRefreshRoute extends PageRouteInfo<void> {
  const BreakingNewsWithRefreshRoute()
      : super(
          BreakingNewsWithRefreshRoute.name,
          path: '/breaking-news-with-refresh',
        );

  static const String name = 'BreakingNewsWithRefreshRoute';
}

/// generated route for
/// [BreakingNewsWithTimer]
class BreakingNewsWithTimerRoute extends PageRouteInfo<void> {
  const BreakingNewsWithTimerRoute()
      : super(
          BreakingNewsWithTimerRoute.name,
          path: '/breaking-news-with-timer',
        );

  static const String name = 'BreakingNewsWithTimerRoute';
}

/// generated route for
/// [ArticleDetailsPage]
class ArticleDetailsViewRoute
    extends PageRouteInfo<ArticleDetailsViewRouteArgs> {
  ArticleDetailsViewRoute({
    Key? key,
    required Article article,
  }) : super(
          ArticleDetailsViewRoute.name,
          path: '/article-details-view',
          args: ArticleDetailsViewRouteArgs(
            key: key,
            article: article,
          ),
        );

  static const String name = 'ArticleDetailsViewRoute';
}

class ArticleDetailsViewRouteArgs {
  const ArticleDetailsViewRouteArgs({
    this.key,
    required this.article,
  });

  final Key? key;

  final Article article;

  @override
  String toString() {
    return 'ArticleDetailsViewRouteArgs{key: $key, article: $article}';
  }
}

/// generated route for
/// [SavedArticlesPage]
class SavedArticlesPageRoute extends PageRouteInfo<void> {
  const SavedArticlesPageRoute()
      : super(
          SavedArticlesPageRoute.name,
          path: '/saved-articles-page',
        );

  static const String name = 'SavedArticlesPageRoute';
}
