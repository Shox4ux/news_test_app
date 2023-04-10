import 'package:flutter/material.dart';
import 'package:news_test_app/src/domain/models/article.dart';
import 'package:news_test_app/src/domain/models/requests/breaking_news.request.dart';
import 'package:news_test_app/src/domain/repositories/api_repository.dart';
import 'package:news_test_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:news_test_app/src/utils/constants/nums.dart';
import 'package:news_test_app/src/utils/resources/data_state.dart';
import 'package:oktoast/oktoast.dart';
part 'refresh_acticles_state.dart';

class RefreshActiclesCubit
    extends BaseCubit<RefreshActiclesState, List<Article>> {
  final ApiRepository _apiRepository;
  int _page = 1;

  RefreshActiclesCubit(this._apiRepository)
      : super(RefreshArticlesLoading(), []);

  Future<void> getBreakingNewsArticles({required bool isJustRefresh}) async {
    if (isBusy) return;

    await run(
      () async {
        final response = await _apiRepository.getAllNewsArticles(
          request: BreakingNewsRequest(page: _page),
        );

        if (response is DataSuccess) {
          final articles = response.data!.articles;
          final noMoreData = articles.length < defaultPageSize;

          data.addAll(articles);
          if (!isJustRefresh) {
            _page++;
          }

          emit(RefreshArticlesSuccess(articles: data, noMoreData: noMoreData));
        } else if (response is DataFailed) {
          if (response.error?.response?.statusCode == APILimitErrorCode) {
            emit(RefreshArticlesLoading());
            Future.delayed(
              const Duration(seconds: 2),
              () {
                emit(RefreshArticlesSuccess(articles: data, noMoreData: true));
                showToast('Server limitation');
              },
            );
            return;
          }
          emit(RefreshArticlesFailed(
            errorMessage: response.error?.response?.data["message"] ??
                "Something went wrong",
          ));
        }
      },
    );
  }
}
