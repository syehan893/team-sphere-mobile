import 'package:equatable/equatable.dart';

import 'models.dart';

class LeaveRequest extends Equatable {
  final int requestId;
  final String employeeId;
  final String leaveType;
  final String startDate;
  final String endDate;
  final int totalDays;
  final String reason;
  final String status;
  final String managerId;
  final String managerComment;
  final String createdAt;
  final String updatedAt;
  final Employee? employee;

  const LeaveRequest({
    required this.requestId,
    required this.employeeId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.reason,
    required this.status,
    required this.managerId,
    required this.managerComment,
    required this.createdAt,
    required this.updatedAt,
    required this.employee,
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      requestId: json['request_id'],
      employeeId: json['employee_id'],
      leaveType: json['leave_type'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      totalDays: json['total_days'],
      reason: json['reason'],
      status: json['status'],
      managerId: json['manager_id'],
      managerComment: json['manager_comment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      employee: json['employee'] != null ? Employee.fromJson(json['employee']) : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'leave_type': leaveType,
      'start_date': startDate,
      'end_date': endDate,
      'total_days': totalDays,
      'reason': reason,
      'status': status,
      'manager_id': managerId,
      'manager_comment': managerComment,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }


  @override
  List<Object> get props {
    return [
      requestId,
      employeeId,
      leaveType,
      startDate,
      endDate,
      totalDays,
      reason,
      status,
      managerId,
      managerComment,
      createdAt,
      updatedAt,
    ];
  }
}
