part of 'timer_articles_cubit.dart';

abstract class TimerArticlesState {
  final List<Article> articles;
  final bool noMoreData;
  final String? errorMessage;

  const TimerArticlesState({
    this.articles = const [],
    this.noMoreData = true,
    this.errorMessage,
  });
}

class TimerActiclesInitial extends TimerArticlesState {
  TimerActiclesInitial();
}

class TimerArticlesLoading extends TimerArticlesState {
  const TimerArticlesLoading();
}

class TimerArticlesSuccess extends TimerArticlesState {
  const TimerArticlesSuccess({super.articles, super.noMoreData});
}

class TimerArticlesFailed extends TimerArticlesState {
  const TimerArticlesFailed({super.errorMessage});
}
