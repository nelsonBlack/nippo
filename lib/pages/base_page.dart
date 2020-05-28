import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:nippo/components/templates/bubble_bottom_nav_bar.dart';
import 'package:nippo/pages/post/post_list_page.dart';
import 'package:nippo/pages/profile/profile_page.dart';
import 'package:nippo/pages/user/user_list_page.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier/state_notifier.dart';

class BasePage extends StatelessWidget {
  const BasePage._({Key key}) : super(key: key);
  static const String routeName = '/home';

  static Widget wrapped() {
    return StateNotifierProvider<BottomNavigationBarController, int>(
      create: (context) => BottomNavigationBarController(),
      child: const BasePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(),
      bottomNavigationBar: BubbleBottomNavBar(
        index: context.select((int s) => s),
        onTap: (index) {
          context.read<BottomNavigationBarController>().change(index: index);
        },
      ),
    );
  }
}

class PageView extends StatelessWidget {
  Widget _currentPage({int page}) {
    final pageList = [HomeListPage(), UserPage.wrapped(), ProfilePage()];
    return pageList[page];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _currentPage(page: context.select((int s) => s)),
    );
  }
}

class BottomNavigationBarController extends StateNotifier<int> {
  BottomNavigationBarController() : super(0);
  void change({int index}) {
    state = index;
    print('change to bottomNavIndex: $index');
  }
}
