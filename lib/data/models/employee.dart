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
      managerId: json['manager_id'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'hire_date': hireDate,
      'job_title': jobTitle,
      'department_id': departmentId,
      'manager_id': managerId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  Employee copyWith({
    String? employeeId,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? hireDate,
    String? jobTitle,
    String? departmentId,
    String? managerId,
    String? createdAt,
    String? updatedAt,
  }) {
    return Employee(
      employeeId: employeeId ?? this.employeeId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      hireDate: hireDate ?? this.hireDate,
      jobTitle: jobTitle ?? this.jobTitle,
      departmentId: departmentId ?? this.departmentId,
      managerId: managerId ?? this.managerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
