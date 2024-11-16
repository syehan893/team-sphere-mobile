import 'package:equatable/equatable.dart';

import '../data.dart';

class EmployeeRollCall extends Equatable {
  final int? rollCallId;
  final String employeeId;
  final String date;
  final String timeIn;
  final String status;
  final String notes;
  final String? createdAt;
  final String? updatedAt;
  final Employee employee;

  const EmployeeRollCall({
    this.rollCallId,
    required this.employeeId,
    required this.date,
    required this.timeIn,
    required this.status,
    required this.notes,
    this.createdAt,
    this.updatedAt,
    required this.employee,
  });

  factory EmployeeRollCall.fromJson(Map<String, dynamic> json) {
    return EmployeeRollCall(
      rollCallId: json['roll_call_id'],
      employeeId: json['employee_id'],
      date: json['date'],
      timeIn: json['time_in'],
      status: json['status'],
      notes: json['notes'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      employee: Employee.fromJson(json['employee']),
    );
  }

  @override
  List<Object?> get props => [
        rollCallId,
        employeeId,
        date,
        timeIn,
        status,
        notes,
        createdAt,
        updatedAt,
        employee,
      ];

  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'date': date,
      'time_in': timeIn,
      'status': status,
      'notes': notes,
    };
  }
}
