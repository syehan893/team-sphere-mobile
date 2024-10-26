// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'models.dart';

class LeaveRequest extends Equatable {
  final int? requestId;
  final String employeeId;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final String reason;
  final String status;
  final String managerId;
  final String managerComment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
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
      startDate: json['start_date'] != null ?  DateTime.parse(json['start_date']) : DateTime.now(),
      endDate: json['end_date'] != null ?  DateTime.parse(json['end_date']) : DateTime.now(),
      totalDays: json['total_days'],
      reason: json['reason'],
      status: json['status'],
      managerId: json['manager_id'],
      managerComment: json['manager_comment'],
      createdAt: json['created_at'] != null ?  DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ?  DateTime.parse(json['updated_at']) : DateTime.now(),
      employee: json['employee'] != null ? Employee.fromJson(json['employee']) : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'leave_type': leaveType,
      'start_date': startDate.toString(),
      'end_date': endDate.toString(),
      'total_days': totalDays,
      'reason': reason,
      'status': status,
      'manager_id': managerId,
      'manager_comment': managerComment,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }


  @override
  List<Object?> get props {
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

  LeaveRequest copyWith({
    int? requestId,
    String? employeeId,
    String? leaveType,
    DateTime? startDate,
    DateTime? endDate,
    int? totalDays,
    String? reason,
    String? status,
    String? managerId,
    String? managerComment,
    DateTime? createdAt,
    DateTime? updatedAt,
    Employee? employee,
  }) {
    return LeaveRequest(
      requestId: requestId ?? this.requestId,
      employeeId: employeeId ?? this.employeeId,
      leaveType: leaveType ?? this.leaveType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalDays: totalDays ?? this.totalDays,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      managerId: managerId ?? this.managerId,
      managerComment: managerComment ?? this.managerComment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      employee: employee ?? this.employee,
    );
  }
}
