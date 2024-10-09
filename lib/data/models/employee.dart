import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String employeeId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String hireDate;
  final String jobTitle;
  final String departmentId;
  final String? managerId;
  final String createdAt;
  final String updatedAt;

  const Employee({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.hireDate,
    required this.jobTitle,
    required this.departmentId,
    this.managerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeId: json['employee_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      hireDate: json['hire_date'],
      jobTitle: json['job_title'],
      departmentId: json['department_id'],
      managerId: json['manager_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  List<Object?> get props => [
        employeeId,
        firstName,
        lastName,
        email,
        phoneNumber,
        hireDate,
        jobTitle,
        departmentId,
        managerId,
        createdAt,
        updatedAt,
      ];
}
