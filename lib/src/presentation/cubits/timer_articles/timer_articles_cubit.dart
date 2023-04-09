import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:oktoast/oktoast.dart';

import '../../../domain/models/article.dart';
import '../../../domain/models/requests/breaking_news.request.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/constants/nums.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';

part 'timer_articles_state.dart';

class TimerArticlesCubit extends BaseCubit<TimerArticlesState, List<Article>> {
  final ApiRepository _apiRepository;

  TimerArticlesCubit(this._apiRepository)
      : super(const TimerArticlesLoading(), []);

  int _page = 1;
  bool _isTimerRunning = false;
  bool _shouldStopTimer = false;

  Future<void> getBreakingNewsArticlesWithTimer() async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.getBreakingNewsArticles(
        request: BreakingNewsRequest(page: _page),
      );

      if (response is DataSuccess) {
        final articles = response.data!.articles;
        final noMoreData = articles.length < defaultPageSize;

        data.addAll(articles);
        _page++;
        emit(TimerArticlesSuccess(articles: data, noMoreData: noMoreData));

        // the starting point of the timer
        await startTimer();
      } else if (response is DataFailed) {
        if (response.error?.response?.statusCode == APILimitErrorCode) {
          emit(TimerArticlesLoading());
          Future.delayed(
            const Duration(seconds: 2),
            () {
              emit(TimerArticlesSuccess(articles: data, noMoreData: true));
              showToast('Server limitation');
            },
          );
          return;
        }

        emit(TimerArticlesFailed(error: response.error));
      }
    });
  }

  void stopTimer() {
    _shouldStopTimer = true;
  }

  Future<void> startTimer() async {
    if (_isTimerRunning) return;
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      print("timer on the move");
      if (_shouldStopTimer) {
        timer.cancel();
      }
      _isTimerRunning = true;
      await _getNewsArticlesPeriodicly();
    });
  }

  Future<void> _getNewsArticlesPeriodicly() async {
    final response = await _apiRepository.getBreakingNewsArticles(
      request: BreakingNewsRequest(page: _page),
    );

    if (response is DataSuccess) {
      final articles = response.data!.articles;
      final noMoreData = articles.length < defaultPageSize;

      data.addAll(articles);
      emit(TimerArticlesSuccess(articles: data, noMoreData: noMoreData));
    } else if (response is DataFailed) {
      emit(TimerArticlesFailed(error: response.error));
    }
  }
}
