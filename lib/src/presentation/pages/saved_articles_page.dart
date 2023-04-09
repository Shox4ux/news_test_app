import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../config/router/app_router.dart';
import '../../domain/models/article.dart';
import '../cubits/local_articles/local_articles_cubit.dart';
import '../widgets/article_widget.dart';

class SavedArticlesPage extends HookWidget {
  const SavedArticlesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: BlocBuilder<LocalArticlesCubit, LocalArticlesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case LocalArticlesLoading:
              return const Center(child: CupertinoActivityIndicator());
            case LocalArticlesSuccess:
              return _buildArticlesList(state.articles);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildArticlesList(List<Article> articles) {
    if (articles.isEmpty) {
      return const Center(
          child: Text(
        'NO SAVED ARTICLES',
        style: TextStyle(color: Colors.black),
      ));
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleWidget(
          article: articles[index],
          isRemovable: true,
          onRemove: (article) => BlocProvider.of<LocalArticlesCubit>(context)
              .removeArticle(article: article),
          onArticlePressed: (article) => appRouter.push(
            ArticleDetailsViewRoute(article: article),
          ),
        );
      },
    );
  }
}
