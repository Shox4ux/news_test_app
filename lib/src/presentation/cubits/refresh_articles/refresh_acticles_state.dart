part of 'refresh_acticles_cubit.dart';

abstract class RefreshActiclesState {
  final List<Article> articles;
  final bool noMoreData;
  final String? errorMessage;
  const RefreshActiclesState({
    this.articles = const [],
    this.noMoreData = true,
    this.errorMessage,
  });
}

class RefreshActiclesInitial extends RefreshActiclesState {
  RefreshActiclesInitial();
}

class RefreshArticlesLoading extends RefreshActiclesState {}

class RefreshArticlesSuccess extends RefreshActiclesState {
  RefreshArticlesSuccess({super.articles, super.noMoreData});
}

class RefreshArticlesFailed extends RefreshActiclesState {
  RefreshArticlesFailed({super.errorMessage});
}
