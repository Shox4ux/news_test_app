part of 'timer_articles_cubit.dart';

abstract class TimerArticlesState extends Equatable {
  final List<Article> articles;
  final bool noMoreData;
  final DioError? error;

  const TimerArticlesState({
    this.articles = const [],
    this.noMoreData = true,
    this.error,
  });

  @override
  List<Object?> get props => [articles, noMoreData, error];
}

class TimerArticlesLoading extends TimerArticlesState {
  const TimerArticlesLoading();
}

class TimerArticlesSuccess extends TimerArticlesState {
  const TimerArticlesSuccess({super.articles, super.noMoreData});
}

class TimerArticlesFailed extends TimerArticlesState {
  const TimerArticlesFailed({super.error});
}
