import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';
import 'package:team_sphere_mobile/core/injection/injection.dart';

import '../cubits/cubit.dart';

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
        BlocProvider(create: (context) => getIt<EmployeeCubit>()),
        BlocProvider(create: (context) => getIt<EmployeeAvatarCubit>()),
        BlocProvider(
            create: (context) => getIt<FetchReimbursementRequestCubit>()),
        BlocProvider(create: (context) => getIt<FetchLeaveRequestCubit>()),
        BlocProvider(
            create: (context) => getIt<EmployeeRollCallCubit>()
              ..getEmployeeRollCallsByDay(
                  Util.formatDateStandard(DateTime.now().toString()))),
      ],
      child: child,
    );
  }
}
