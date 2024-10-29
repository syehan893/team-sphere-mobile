import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:team_sphere_mobile/app/themes/colors.dart';
import 'package:team_sphere_mobile/core/injection/injection.dart';

import '../../cubits/cubit.dart';
import '../../widgets/widgets.dart';

class ReimbursementRequestScreen extends StatelessWidget {
  const ReimbursementRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateReimbursementRequestCubit>(),
      child: const ReimbursementRequestContent(),
    );
  }
}

class ReimbursementRequestContent extends StatelessWidget {
  const ReimbursementRequestContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateReimbursementRequestCubit>();

    return BaseLayout(
      resizeAvoidButton: false,
      title: 'Reimbursement Request',
      useBackButton: true,
      body: BlocBuilder<CreateReimbursementRequestCubit,
          CreateReimbursementRequestState>(
        builder: (context, state) {
          if (state.status == CreateReimbursementRequestStatus.loading) {
            return Center(
                child: LoadingAnimationWidget.progressiveDots(
              color: TSColors.primary.p100,
              size: 50,
            ));
          }
          return BlocBuilder<EmployeeCubit, EmployeeState>(
            builder: (context, employeeState) {
              if (employeeState is EmployeeLoaded) {
                context.read<CreateReimbursementRequestCubit>().updateField(
                    employeeId: employeeState.employee.managerId ??
                        employeeState.employee.employeeId);
                context
                    .read<CreateReimbursementRequestCubit>()
                    .updateField(managerId: employeeState.employee.employeeId);
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Submit your reimburse',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextInput(
                      onChanged: (value) => cubit.updateField(title: value),
                      label: 'Title',
                    ),
                    const SizedBox(height: 24),
                    _buildDatePicker(context, cubit),
                    const SizedBox(height: 24),
                    _buildDropdown(cubit),
                    const SizedBox(height: 40),
                    Center(child: _buildFileUpload(cubit)),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: Button(
                        title: 'Submit',
                        onTap: () {
                          cubit.createReimbursementRequest();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDatePicker(
      BuildContext context, CreateReimbursementRequestCubit cubit) {
    return InkWell(
      key: key,
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2024),
          lastDate: DateTime(2025),
        );
        if (picked != null) {
          cubit.updateField(date: picked);
        }
      },
      child: BlocBuilder<CreateReimbursementRequestCubit,
          CreateReimbursementRequestState>(
        builder: (context, state) {
          return TextInput(
            key: Key('key-${state.reimbursementRequest.expenseDate}'),
            initialValue: DateFormat('dd/MM/yyyy')
                .format(state.reimbursementRequest.expenseDate)
                .toString(),
            enabled: false,
            label: DateFormat('dd/MM/yyyy')
                .format(state.reimbursementRequest.expenseDate)
                .toString(),
            suffixWidget: const Icon(Icons.calendar_today),
          );
        },
      ),
    );
  }

  Widget _buildDropdown(CreateReimbursementRequestCubit cubit) {
    return BlocBuilder<CreateReimbursementRequestCubit,
        CreateReimbursementRequestState>(
      builder: (context, state) {
        return TextInput(
          key: Key(
              'reimbursement-type-${state.reimbursementRequest.expenseType}'),
          label: 'Reimbursement Type',
          initialValue: state.reimbursementRequest.expenseType,
          onChanged: (newValue) {
            context.read<CreateLeaveRequestCubit>().updateLeaveType(newValue!);
          },
          dropdownOptions: const ['Software', 'Hardware', 'Travel', 'Other'],
        );
      },
    );
  }

  Widget _buildFileUpload(CreateReimbursementRequestCubit cubit) {
    return BlocBuilder<CreateReimbursementRequestCubit,
        CreateReimbursementRequestState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width / 0.75,
          decoration: BoxDecoration(
            color: TSColors.primary.p30,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Body1.regular(
                state.reimbursementRequest.receiptFilePath.isEmpty
                    ? 'No file selected'
                    : state.reimbursementRequest.receiptFilePath,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Button(
                leading: const Icon(Icons.cloud_upload, color: Colors.white),
                title: 'Upload',
                onTap: () async {
                  await selectFile(cubit);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> selectFile(CreateReimbursementRequestCubit cubit) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);

      final fileBytes = await file.readAsBytes();
      final fileName = result.files.single.name;

      cubit.selectFile(fileName, fileBytes);
      cubit.updateField(fileName: fileName);
    }
  }
}
