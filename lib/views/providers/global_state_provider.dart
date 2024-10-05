import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_sphere_mobile/core/injection/injection.dart';
import 'package:team_sphere_mobile/views/screens/auth/cubit/login_cubit.dart';
import 'package:team_sphere_mobile/views/screens/homepage/cubit/home_cubit.dart';

class GlobalStateProvider extends StatelessWidget {
  final Widget child;
  const GlobalStateProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<HomeCubit>()),
      ],
      child: child,
    );
  }
}
