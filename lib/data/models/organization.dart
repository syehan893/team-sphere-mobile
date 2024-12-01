import 'package:equatable/equatable.dart';

class Organization extends Equatable {
  final String departmentId;
  final String departmentName;
  final String departmentCode;
  final int level;
  final String? parentDepartmentId;
  final String managerId;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String type;
  final List<Organization> children;

  const Organization({
    required this.departmentId,
    required this.departmentName,
    required this.departmentCode,
    required this.level,
    this.parentDepartmentId,
    required this.managerId,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.children,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      departmentId: json['department_id'] as String,
      departmentName: json['department_name'] as String,
      departmentCode: json['department_code'] as String,
      level: json['level'] as int,
      parentDepartmentId: json['parent_department_id'] as String?,
      managerId: json['manager_id'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      type: json['type'] as String,
      children: json['children'] != []
          ? (json['children'] as List<dynamic>)
              .map((child) =>
                  Organization.fromJson(child as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'department_id': departmentId,
      'department_name': departmentName,
      'department_code': departmentCode,
      'level': level,
      'parent_department_id': parentDepartmentId,
      'manager_id': managerId,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'type': type,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props {
    return [
      departmentId,
      departmentName,
      departmentCode,
      level,
      parentDepartmentId,
      managerId,
      description,
      createdAt,
      updatedAt,
      type,
      children,
    ];
  }
}
