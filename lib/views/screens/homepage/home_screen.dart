import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/gen/assets.gen.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

import '../screen.dart';
import 'cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  static const Map<HomeNavBar, String?> titles = {
    HomeNavBar.home: null,
    HomeNavBar.transaction: 'Transaction',
    HomeNavBar.task: 'Task(s)',
    HomeNavBar.user: null,
  };

  static const List<HomeNavBar> navBars = [
    HomeNavBar.home,
    HomeNavBar.transaction,
    HomeNavBar.task,
    HomeNavBar.user,
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    TransactionScreen(),
    TaskScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return BaseLayout(
          title: titles[state.homeNavBar],
          useBackButton: false,
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            selectedItemColor: PColors.primary.p100,
            selectedLabelStyle: TextStyles.body1Bold,
            unselectedLabelStyle: TextStyles.body1Regular,
            unselectedIconTheme: IconThemeData(
              color: PColors.shades.loEm,
            ),
            selectedIconTheme: IconThemeData(
              color: PColors.primary.p100,
            ),
            unselectedItemColor: PColors.shades.loEm,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: mapNavBarIcon(
                    state, Assets.icons.homeIcon.path, HomeNavBar.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: mapNavBarIcon(state, Assets.icons.transactionIcon.path,
                    HomeNavBar.transaction),
                label: 'Transaction',
              ),
              BottomNavigationBarItem(
                icon: mapNavBarIcon(
                    state, Assets.icons.taskIcon.path, HomeNavBar.task),
                label: 'Task',
              ),
              BottomNavigationBarItem(
                icon: mapNavBarIcon(
                    state, Assets.icons.profileIcon.path, HomeNavBar.user),
                label: 'User',
              ),
            ],
            currentIndex: navBars.indexOf(state.homeNavBar),
            onTap: (value) {
              _pageController.animateToPage(
                value,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              context.read<HomeCubit>().changeNavBar(navBars[value]);
            },
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              context.read<HomeCubit>().changeNavBar(navBars[index]);
            },
            physics: const ClampingScrollPhysics(),
            children: _widgetOptions,
          ),
        );
      },
    );
  }

  Image mapNavBarIcon(HomeState state, String imagePath, HomeNavBar navBar) {
    return Image.asset(
      imagePath,
      color: state.homeNavBar == navBar
          ? PColors.primary.p100
          : PColors.shades.loEm,
      width: 24,
      height: 24,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
