import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/views/screens/auth/cubit/login_cubit.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

import 'cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<HomeNavBar> navBars = [
    HomeNavBar.home,
    HomeNavBar.transaction,
    HomeNavBar.task,
    HomeNavBar.user,
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    Body1.regular(
      'Index 0: Home',
    ),
    Body1.regular(
      'Index 1: Transaction',
    ),
    Body1.regular(
      'Index 2: Task',
    ),
    Body1.regular(
      'Index 3: User',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseLayout(bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: PColors.primary.p400,
          selectedLabelStyle: TextStyles.body1Regular,
          unselectedLabelStyle:  TextStyle(
            color: PColors.shades.loEm, 
          ),
          selectedIconTheme: IconThemeData(
            color: PColors.primary.p400, 
          ),
          unselectedItemColor:
              PColors.shades.loEm, 
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.data_object_outlined),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'User',
            ),
          ],
          currentIndex: navBars.indexOf(state.homeNavBar),
          onTap: (value) {
            context.read<HomeCubit>().changeNavBar(navBars[value]);
          },
        );
      },
    ), body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _widgetOptions[navBars.indexOf(state.homeNavBar)],
            TextButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                },
                child: const Text('Kembali Ke Login'))
          ],
        );
      },
    ));
  }
}
