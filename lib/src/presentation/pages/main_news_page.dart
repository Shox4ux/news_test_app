import 'package:flutter/material.dart';
import 'package:news_test_app/src/presentation/pages/refresh_news_page.dart';
import 'package:news_test_app/src/presentation/pages/saved_articles_page.dart';
import 'package:news_test_app/src/presentation/pages/timer_news_page.dart';
import 'package:news_test_app/src/utils/constants/app_colors.dart';

class MainNewsPage extends StatelessWidget {
  const MainNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: const Text(
              'Daily News',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.timer, color: AppColors.mainColor)),
                Tab(icon: Icon(Icons.refresh, color: AppColors.mainColor)),
                Tab(icon: Icon(Icons.inbox, color: AppColors.mainColor)),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                BreakingNewsWithTimer(),
                BreakingNewsWithRefresh(),
                SavedArticlesPage()
              ]),
            )
          ],
        ),
      ),
    );
  }
}
