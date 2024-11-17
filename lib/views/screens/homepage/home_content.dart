import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import 'package:team_sphere_mobile/core/helpers/utils.dart';
import 'package:team_sphere_mobile/data/data.dart';
import 'package:team_sphere_mobile/gen/assets.gen.dart';
import 'package:action_slider/action_slider.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

import '../../cubits/cubit.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<EmployeeCubit, EmployeeState>(
                    builder: (context, state) {
                      if (state is EmployeeLoaded) {
                        return DynamicGreetingWidget(
                            name:
                                'Hi, ${state.employee.firstName} ${state.employee.lastName}');
                      }
                      return const DynamicGreetingWidget(name: 'Hallo...');
                    },
                  ),
                  const SizedBox(height: 20),
                  const RollCallCard(),
                  const SizedBox(height: 20),
                  const Text('Features',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFeatureIcon(
                          Assets.icons.earthAirplane.path, 'Leave', () {
                        context.go('/leave');
                      }),
                      _buildFeatureIcon(
                          Assets.icons.dollarCoin.path, 'Reimburse', () {
                        context.go('/reimburse');
                      }),
                      _buildFeatureIcon(
                          Assets.icons.userMultipleGroup.path, 'Member', () {}),
                      _buildFeatureIcon(
                          Assets.icons.newsPaper.path, 'News', () {}),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('News',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ImageCarousel(
                      images: const [
                        'https://gqrrkswdhnhahfvgjzkj.supabase.co/storage/v1/object/public/company_news/news-1.png',
                        'https://gqrrkswdhnhahfvgjzkj.supabase.co/storage/v1/object/public/company_news/news-2.png'
                      ],
                      onTap: (index) {
                        context.go('/news');
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      H3('Colleagues'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildCollaguesCard(),
                ],
              ),
            ),
            BlocBuilder<EmployeeCubit, EmployeeState>(
              builder: (context, state) {
                if (state is EmployeeLoaded) {
                  final employee = state.employee;
                  return BlocBuilder<EmployeeRollCallCubit,
                      EmployeeRollCallState>(
                    builder: (context, state) {
                      final notRollCalled = state.rollCalls != [] &&
                              state.rollCalls != null
                          ? state.rollCalls!
                              .where((e) => e.employeeId == employee.employeeId)
                              .isEmpty
                          : false;
                      if (state.status == FetchStatus.loaded && notRollCalled) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: ActionSlider.standard(
                            toggleColor: TSColors.background.b100,
                            backgroundColor: TSColors.primary.p100,
                            icon: const Icon(Icons.arrow_forward_rounded),
                            backgroundBorderRadius: BorderRadius.circular(8),
                            foregroundBorderRadius: BorderRadius.circular(8),
                            child: const Body1.regular('Swipe to check in',
                                fontSize: 18, color: Colors.white),
                            action: (controller) async {
                              controller.loading();
                              await saveRollCall(context, employee);
                              controller.success();
                              // ignore: use_build_context_synchronously
                              context
                                  .read<EmployeeRollCallCubit>()
                                  .getEmployeeRollCallsByDay(
                                      Util.formatDateStandard(
                                          DateTime.now().toString()));
                            },
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> saveRollCall(BuildContext context, Employee employee) async {
    await context.read<EmployeeRollCallCubit>().saveRollCall(EmployeeRollCall(
          employeeId: employee.employeeId,
          date: Util.formatStandartTimestamp(DateTime.now().toString()),
          timeIn: Util.formatTimestamp(DateTime.now().toString()),
          status: "Present",
          notes: "N/A",
          employee: employee,
        ));
  }

  Widget _buildCollaguesCard() {
    return BlocBuilder<EmployeeRollCallCubit, EmployeeRollCallState>(
      builder: (context, state) {
        if (state.status == FetchStatus.loaded) {
          if (state.rollCalls!.isNotEmpty && state.rollCalls != null) {
            return SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      state.rollCalls?.length ?? 0,
                      (index) {
                        final rollCall = state.rollCalls?[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: TSColors.secondary.s70),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              EmployeeAvatar(
                                  email: rollCall!.employee.email, radius: 24),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  H3('${rollCall.employee.firstName} ${rollCall.employee.lastName}'),
                                  Body1.regular(rollCall.employee.jobTitle),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildFeatureIcon(String path, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            minRadius: 35,
            backgroundColor: TSColors.secondary.s30,
            child: Image.asset(path, height: 35, width: 35),
          ),
          const SizedBox(height: 5),
          Body1.bold(label),
        ],
      ),
    );
  }
}

class RollCallCard extends StatelessWidget {
  const RollCallCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeRollCallCubit, EmployeeRollCallState>(
      builder: (context, state) {
        if (state.status == FetchStatus.loaded) {
          return BlocBuilder<EmployeeCubit, EmployeeState>(
            builder: (context, employeeState) {
              if (employeeState is EmployeeLoaded) {
                final employeeId = employeeState.employee.employeeId;
                final rollCalls = state.rollCalls
                    ?.where((e) => e.employeeId == employeeId)
                    .toList();
                final rollCall = rollCalls != null && rollCalls.isNotEmpty
                    ? rollCalls.first
                    : null;

                final isNotRollCalled = rollCall == null;
                final displayDateTime = rollCall != null
                    ? DateTime.parse(rollCall.timeIn)
                    : DateTime.now();

                return _buildCard(
                  imagePath: isNotRollCalled
                      ? Assets.images.locationDynamicColor.path
                      : Assets.images.tickDynamicColor.path,
                  dateTime: displayDateTime,
                );
              }
              return _buildDefaultCard();
            },
          );
        }
        return _buildDefaultCard();
      },
    );
  }

  Widget _buildCard({required String imagePath, required DateTime dateTime}) {
    final formattedDate = DateFormat('EEEE, dd MMM yyyy').format(dateTime);
    final formattedTime = DateFormat('hh:mm a').format(dateTime);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TSColors.secondary.s30,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 64, width: 64),
          const SizedBox(width: 21),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              H3(formattedDate),
              H3(formattedTime),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultCard() {
    return _buildCard(
      imagePath: Assets.images.locationDynamicColor.path,
      dateTime: DateTime.now(),
    );
  }
}
