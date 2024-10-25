import 'package:equatable/equatable.dart';

import 'models.dart';

class ReimbursementRequest extends Equatable {
  final int requestId;
  final String employeeId;
  final String requestDate;
  final String expenseDate;
  final String expenseType;
  final int amount;
  final String currency;
  final String description;
  final String receiptFilePath;
  final String status;
  final String managerId;
  final String managerComment;
  final String createdAt;
  final String updatedAt;
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
      requestDate: json['request_date'],
      expenseDate: json['expense_date'],
      expenseType: json['expense_type'],
      amount: json['amount'],
      currency: json['currency'],
      description: json['description'],
      receiptFilePath: json['receipt_file_path'],
      status: json['status'],
      managerId: json['manager_id'],
      managerComment: json['manager_comment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      employee:
          json['employee'] != null ? Employee.fromJson(json['employee']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'employee_id': employeeId,
      'request_date': requestDate,
      'expense_date': expenseDate,
      'expense_type': expenseType,
      'amount': amount,
      'currency': currency,
      'description': description,
      'receipt_file_path': receiptFilePath,
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
}
