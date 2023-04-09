import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_test_app/src/presentation/cubits/local_articles/local_articles_cubit.dart';
import 'package:news_test_app/src/presentation/cubits/refresh_articles/refresh_acticles_cubit.dart';
import 'package:news_test_app/src/presentation/widgets/error_widget.dart';
import 'package:news_test_app/src/utils/constants/app_colors.dart';
import 'package:oktoast/oktoast.dart';
import '../../config/router/app_router.dart';
import '../../utils/extensions/scroll_controller_extensions.dart';
import '../widgets/article_widget.dart';

class BreakingNewsWithRefresh extends HookWidget {
  const BreakingNewsWithRefresh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final refreshArticlesCubit = BlocProvider.of<RefreshActiclesCubit>(context);
    final localArticlesCubit = BlocProvider.of<LocalArticlesCubit>(context);

    final scrollController = useScrollController();

    useEffect(() {
      scrollController.onScrollEndsListener(() async {
        await refreshArticlesCubit.getBreakingNewsArticles(
            isJustRefresh: false);
      });
      return;
    }, const []);

    return RefreshIndicator(
      color: AppColors.mainColor,
      onRefresh: () async {
        await refreshArticlesCubit.getBreakingNewsArticles(isJustRefresh: true);
      },
      child: SizedBox.expand(
        child: BlocBuilder<RefreshActiclesCubit, RefreshActiclesState>(
          builder: (_, state) {
            switch (state.runtimeType) {
              case RefreshArticlesLoading:
                return const Center(child: CupertinoActivityIndicator());
              case RefreshArticlesFailed:
                return Center(
                  child: CustomErrorWidget(
                    message: state.errorMessage ?? "",
                    fun: () async {
                      await refreshArticlesCubit.getBreakingNewsArticles(
                          isJustRefresh: true);
                    },
                  ),
                );
              case RefreshArticlesSuccess:
                return CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ArticleWidget(
                          isRemovable: false,
                          article: state.articles[index],
                          onArticlePressed: (article) => appRouter.push(
                            ArticleDetailsViewRoute(article: article),
                          ),
                          onArticleAddPressed: (article) {
                            localArticlesCubit.saveArticle(article: article);
                            showToast("Article is saved");
                          },
                        ),
                        childCount: state.articles.length,
                      ),
                    ),
                    if (!state.noMoreData)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: 14, bottom: 32),
                          child: CupertinoActivityIndicator(),
                        ),
                      )
                  ],
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
