import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_sphere_mobile/views/cubits/cubit.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

import 'my_reimbursement_list_screen.dart';
import 'reimbursement_pending_list_screen.dart';

class ReimbursementScreen extends StatelessWidget {
  ReimbursementScreen({super.key}) {
    _showPendingRequestsNotifier = ValueNotifier<bool>(false);
  }

  late final ValueNotifier<bool> _showPendingRequestsNotifier;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Reimburse',
      useBackButton: true,
      onBackTap: () => context.go('/home'),
      floatingActionButton: Button(
        title: 'Request Reimburse',
        onTap: () => context.go('/reimburse/request'),
      ),
      body: Column(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: _showPendingRequestsNotifier,
            builder: (context, showPendingRequests, child) {
              return BlocBuilder<EmployeeCubit, EmployeeState>(
                builder: (context, state) {
                  if (state is EmployeeLoaded) {
                    return CustomTabBar(
                      tabLabels: const ['My Reimburse(s)', 'Approval Request'],
                      selectedIndex: showPendingRequests ? 1 : 0,
                      onTabSelected: (index) {
                        if (index == 1) {
                          context
                              .read<FetchReimbursementRequestCubit>()
                              .fetchReimbursementRequestsByManagerId(
                                  state.employee.employeeId);
                        } else {
                          context
                              .read<FetchReimbursementRequestCubit>()
                              .fetchReimbursementRequestsByEmployeeId(
                                  state.employee.employeeId);
                        }

                        _showPendingRequestsNotifier.value = index == 1;
                      },
                    );
                  }
                  return CustomTabBar(
                    tabLabels: const ['My Reimburse(s)', 'Approval Request'],
                    selectedIndex: showPendingRequests ? 1 : 0,
                    onTabSelected: (index) {
                      _showPendingRequestsNotifier.value = index == 1;
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ValueListenableBuilder<bool>(
              valueListenable: _showPendingRequestsNotifier,
              builder: (context, showPendingRequests, child) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: showPendingRequests
                      ? const PendingRequestList(
                          key: ValueKey('PendingRequestList'),
                        )
                      : const MyReimbursementList(
                          key: ValueKey('MyReimbursementList')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
