import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_test_app/src/presentation/pages/main_news_page.dart';
import 'package:news_test_app/src/presentation/pages/saved_articles_page.dart';
import 'package:news_test_app/src/utils/constants/app_colors.dart';

class HomePage extends HookWidget {
  HomePage({super.key});

  // late StreamSubscription subscription;
  // var isInternetConnected = false;
  // bool isAlertSet = false;

  // @override
  // void initState() {
  //   getConnectivity();
  //   super.initState();
  // }

  // getConnectivity() {
  //   subscription = Connectivity().onConnectivityChanged.listen((event) async {
  //     isInternetConnected = await InternetConnectionChecker().hasConnection;
  //     if (!isInternetConnected && isAlertSet == false) {
  //       showDialogBox();
  //       setState(() {
  //         isAlertSet = true;
  //       });
  //     }
  //   });
  // }

  // showDialogBox() {
  //   return showCupertinoDialog(
  //     context: context,
  //     builder: (context) => CupertinoAlertDialog(
  //       title: const Text("Tarmoqda nosozlik"),
  //       content: const Text("Iltimos internetga ulanishni tekshiring"),
  //       actions: [
  //         TextButton(
  //           onPressed: () async {
  //             Navigator.pop(context, "Cancel");
  //             setState(() {
  //               isAlertSet = false;
  //             });
  //             isInternetConnected =
  //                 await InternetConnectionChecker().hasConnection;
  //             if (!isInternetConnected && isAlertSet == false) {
  //               showDialogBox();
  //               setState(() {
  //                 isAlertSet = true;
  //               });
  //             }
  //           },
  //           child: Text(
  //             "Qaytadan",
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   subscription.cancel();
  //   super.dispose();
  // }

  final screens = [
    const MainNewsPage(),
    const SavedArticlesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Daily News',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: screens[selectedIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          selectedIndex.value = value;
        },
        currentIndex: selectedIndex.value,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.mainColor,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            activeIcon: Icon(Icons.newspaper),
            label: "News",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            activeIcon: Icon(Icons.inbox),
            label: "Saved",
          ),
        ],
      ),
    );
  }
}
