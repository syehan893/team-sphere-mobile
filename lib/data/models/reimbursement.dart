import 'package:equatable/equatable.dart';

import 'models.dart';

class ReimbursementRequest extends Equatable {
  final int? requestId;
  final String employeeId;
  final DateTime requestDate;
  final DateTime expenseDate;
  final String expenseType;
  final int amount;
  final String currency;
  final String description;
  final String receiptFilePath;
  final String status;
  final String managerId;
  final String managerComment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Employee? employee;

  const ReimbursementRequest({
    required this.requestId,
    required this.employeeId,
    required this.requestDate,
    required this.expenseDate,
    required this.expenseType,
    required this.amount,
    required this.currency,
    required this.description,
    required this.receiptFilePath,
    required this.status,
    required this.managerId,
    required this.managerComment,
    required this.createdAt,
    required this.updatedAt,
    required this.employee,
  });

  factory ReimbursementRequest.fromJson(Map<String, dynamic> json) {
    return ReimbursementRequest(
      requestId: json['request_id'],
      employeeId: json['employee_id'],
      requestDate: json['request_date'] != null
          ? DateTime.parse(json['request_date'])
          : DateTime.now(),
      expenseDate: json['expense_date'] != null
          ? DateTime.parse(json['expense_date'])
          : DateTime.now(),
      expenseType: json['expense_type'],
      amount: json['amount'],
      currency: json['currency'],
      description: json['description'],
      receiptFilePath: json['receipt_file_path'],
      status: json['status'],
      managerId: json['manager_id'],
      managerComment: json['manager_comment'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      employee:
          json['employee'] != null ? Employee.fromJson(json['employee']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'request_date': requestDate.toString(),
      'expense_date': expenseDate.toString(),
      'expense_type': expenseType,
      'amount': amount,
      'currency': currency,
      'description': description,
      'receipt_file_path': receiptFilePath,
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
      requestDate,
      expenseDate,
      expenseType,
      amount,
      currency,
      description,
      receiptFilePath,
      status,
      managerId,
      managerComment,
      createdAt,
      updatedAt,
    ];
  }

  ReimbursementRequest copyWith({
    int? requestId,
    String? employeeId,
    DateTime? requestDate,
    DateTime? expenseDate,
    String? expenseType,
    int? amount,
    String? currency,
    String? description,
    String? receiptFilePath,
    String? status,
    String? managerId,
    String? managerComment,
    DateTime? createdAt,
    DateTime? updatedAt,
    Employee? employee,
  }) {
    return ReimbursementRequest(
      requestId: requestId ?? this.requestId,
      employeeId: employeeId ?? this.employeeId,
      requestDate: requestDate ?? this.requestDate,
      expenseDate: expenseDate ?? this.expenseDate,
      expenseType: expenseType ?? this.expenseType,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      receiptFilePath: receiptFilePath ?? this.receiptFilePath,
      status: status ?? this.status,
      managerId: managerId ?? this.managerId,
      managerComment: managerComment ?? this.managerComment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      employee: employee ?? this.employee,
    );
  }
}
