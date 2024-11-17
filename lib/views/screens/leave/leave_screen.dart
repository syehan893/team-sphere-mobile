import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import 'package:team_sphere_mobile/views/cubits/cubit.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

import 'leave_list_screen.dart';
import 'leave_pending_list_screen.dart';

class LeaveScreen extends StatelessWidget {
  LeaveScreen({super.key}) {
    _showPendingRequestsNotifier = ValueNotifier<bool>(false);
  }

  late final ValueNotifier<bool> _showPendingRequestsNotifier;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Leave',
      useBackButton: true,
      onBackTap: () => context.go('/home'),
      floatingActionButton: Button(
        title: 'Request Leave',
        onTap: () => context.go('/leave/request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const LeaveCircle(),
            const SizedBox(height: 20),
            const LeaveLegend(),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: _showPendingRequestsNotifier,
              builder: (context, showPendingRequests, child) {
                return BlocBuilder<EmployeeCubit, EmployeeState>(
                  builder: (context, state) {
                    if (state is EmployeeLoaded) {
                      return CustomTabBar(
                        tabLabels: const ['My Leave(s)', 'Approval Request'],
                        selectedIndex: showPendingRequests ? 1 : 0,
                        onTabSelected: (index) {
                          if (index == 1) {
                            context
                                .read<FetchLeaveRequestCubit>()
                                .fetchLeaveRequestsByManagerId(
                                    state.employee.employeeId);
                          } else {
                            context
                                .read<FetchLeaveRequestCubit>()
                                .fetchLeaveRequestsByEmployeeId(
                                    state.employee.employeeId);
                          }

                          _showPendingRequestsNotifier.value = index == 1;
                        },
                      );
                    }
                    return CustomTabBar(
                      tabLabels: const ['My Leave(s)', 'Approval Request'],
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
                        ? const PendingRequestList()
                        : const MyLeavesList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaveCircle extends StatelessWidget {
  const LeaveCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: BlocBuilder<FetchLeaveRequestCubit, FetchLeaveRequestState>(
        builder: (context, state) {
          if (state.employeeFetchStatus == FetchStatus.loaded) {
            final annualData = state.leaveRequests
                ?.where((e) => e.leaveType == 'Annual Leave')
                .length;
            final sickData =
                state.leaveRequests?.where((e) => e.leaveType == 'Sick Leave').length;
            final specialData = state.leaveRequests
                ?.where((e) => e.leaveType == 'Special Leave')
                .length;
            return Center(
              child: PieChart(
                PieChartData(
                  sections: _getChartSections(
                    {
                      'Annual': annualData,
                      'Sick': sickData,
                      'Special': specialData,
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 40,
                ),
              ),
            );
          }
          return Center(
              child: LoadingAnimationWidget.progressiveDots(
            color: TSColors.primary.p100,
            size: 50,
          ));
        },
      ),
    );
  }

  List<PieChartSectionData> _getChartSections(Map data) {
    return data.entries.map((entry) {
      final title = entry.key;
      final value = entry.value;

      return PieChartSectionData(
        color: _getColor(title),
        value: value.toDouble(),
        title: '$value',
      );
    }).toList();
  }

  Color _getColor(String title) {
    switch (title) {
      case 'Annual':
        return Colors.teal;
      case 'Sick':
        return Colors.indigo;
      case 'Special':
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }
}

class LeaveLegend extends StatelessWidget {
  const LeaveLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LegendItem(color: Colors.teal, label: 'Annual'),
        SizedBox(width: 20),
        LegendItem(color: Colors.indigo, label: 'Sick'),
        SizedBox(width: 20),
        LegendItem(color: Colors.cyan, label: 'Special'),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
