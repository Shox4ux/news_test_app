import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_test_app/src/presentation/cubits/timer_articles/timer_articles_cubit.dart';
import 'package:news_test_app/src/presentation/widgets/error_widget.dart';
import 'package:oktoast/oktoast.dart';
import '../../config/router/app_router.dart';
import '../../utils/extensions/scroll_controller_extensions.dart';
import '../cubits/local_articles/local_articles_cubit.dart';
import '../widgets/article_widget.dart';

class BreakingNewsWithTimer extends HookWidget {
  const BreakingNewsWithTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remoteArticlesCubit = BlocProvider.of<TimerArticlesCubit>(context);
    final localArticlesCubit = BlocProvider.of<LocalArticlesCubit>(context);

    final scrollController = useScrollController();

    useEffect(() {
      scrollController.onScrollEndsListener(() async {
        await remoteArticlesCubit.getBreakingNewsArticlesWithTimer();
      });
      return scrollController.dispose;
    }, const []);

    return SizedBox.expand(
      child: BlocBuilder<TimerArticlesCubit, TimerArticlesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case TimerArticlesLoading:
              return const Center(child: CupertinoActivityIndicator());
            case TimerArticlesFailed:
              return Center(
                child: CustomErrorWidget(
                  message: state.errorMessage ?? "",
                  fun: () async {
                    await remoteArticlesCubit
                        .getBreakingNewsArticlesWithTimer();
                  },
                ),
              );
            case TimerArticlesSuccess:
              return CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ArticleWidget(
                        isRemovable: false,
                        article: state.articles[index],
                        onArticlePressed: (e) => appRouter.push(
                          ArticleDetailsViewRoute(article: e),
                        ),
                        onArticleAddPressed: (article) async {
                          await localArticlesCubit.saveArticle(
                              article: article);
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
              ;
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
