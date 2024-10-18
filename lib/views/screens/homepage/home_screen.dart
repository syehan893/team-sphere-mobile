import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/core/constant/animation_duration.dart';
import 'package:team_sphere_mobile/gen/assets.gen.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

import '../../cubits/cubit.dart';
import '../screen.dart';

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
    OrganizationStructureScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeLoaded) {
          String employeeId = state.employee.employeeId;
          context.read<FetchLeaveRequestCubit>()
            ..fetchLeaveRequestsByEmployeeId(employeeId)
            ..fetchLeaveRequestsByManagerId(employeeId);
          context.read<FetchReimbursementRequestCubit>()
            ..fetchReimbursementRequestsByEmployeeId(employeeId)
            ..fetchReimbursementRequestsByManagerId(employeeId);
        }
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BaseLayout(
            title: titles[state.homeNavBar],
            useBackButton: false,
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              selectedItemColor: TSColors.primary.p100,
              selectedLabelStyle: TextStyles.body1Bold,
              unselectedLabelStyle: TextStyles.body1Regular,
              unselectedIconTheme: IconThemeData(
                color: TSColors.shades.loEm,
              ),
              selectedIconTheme: IconThemeData(
                color: TSColors.primary.p100,
              ),
              unselectedItemColor: TSColors.shades.loEm,
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
                      state, Assets.icons.hierarchy.path, HomeNavBar.task),
                  label: 'My Team',
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
                  duration: AnimationDuration.milis300,
                  curve: Curves.easeInOut,
                );
                context.read<HomeCubit>().changeNavBar(navBars[value]);
              },
            ),
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _widgetOptions,
            ),
          );
        },
      ),
    );
  }

  Image mapNavBarIcon(HomeState state, String imagePath, HomeNavBar navBar) {
    return Image.asset(
      imagePath,
      color: state.homeNavBar == navBar
          ? TSColors.primary.p100
          : TSColors.shades.loEm,
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
