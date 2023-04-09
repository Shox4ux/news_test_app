import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_test_app/src/presentation/cubits/timer_articles/timer_articles_cubit.dart';
import 'package:news_test_app/src/presentation/pages/refresh_news_page.dart';
import 'package:news_test_app/src/presentation/pages/saved_articles_page.dart';
import 'package:news_test_app/src/presentation/pages/timer_news_page.dart';
import 'package:news_test_app/src/utils/constants/app_colors.dart';

class MainNewsPage extends HookWidget {
  const MainNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isInternetConnected = useState(false);
    final isAlertSet = useState(false);
    final timedArticlesCubit = BlocProvider.of<TimerArticlesCubit>(context);

    showDialogBox() {
      return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("Connectivity failed"),
          content: const Text("Please check connection"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, "Cancel");
                isAlertSet.value = false;
                timedArticlesCubit.startTimer();
                isInternetConnected.value =
                    await InternetConnectionChecker().hasConnection;
                if (!isInternetConnected.value && isAlertSet.value == false) {
                  showDialogBox();
                  isAlertSet.value = true;
                  timedArticlesCubit.stopTimer();
                }
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    useEffect(() {
      final sub = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isInternetConnected.value =
            (await InternetConnectionChecker().hasConnection);
        if (!isInternetConnected.value && isAlertSet.value == false) {
          showDialogBox();
          isAlertSet.value = true;
          timedArticlesCubit.stopTimer();
        }
      });
      return sub.cancel;
    });

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Daily News',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.timer, color: AppColors.mainColor)),
                Tab(icon: Icon(Icons.refresh, color: AppColors.mainColor)),
                Tab(icon: Icon(Icons.inbox, color: AppColors.mainColor)),
              ],
            ),
            const Expanded(
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
