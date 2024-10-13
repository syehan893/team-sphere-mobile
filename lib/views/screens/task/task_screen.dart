import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

class Department {
  final String id;
  final String name;
  final String code;
  final int level;
  final String? parentId;
  final String managerId;
  final String description;
  final String type;
  final List<Department> children;
  final List<Employee> employees;

  Department({
    required this.id,
    required this.name,
    required this.code,
    required this.level,
    this.parentId,
    required this.managerId,
    required this.description,
    required this.type,
    List<Department>? children,
    List<Employee>? employees,
  })  : children = children ?? [],
        employees = employees ?? [];

  Department copyWith({List<Department>? children}) {
    return Department(
      id: id,
      name: name,
      code: code,
      level: level,
      parentId: parentId,
      managerId: managerId,
      description: description,
      type: type,
      children: children ?? this.children,
      employees: employees,
    );
  }
}

class Employee {
  final String id;
  final String name;
  final String position;

  Employee({required this.id, required this.name, required this.position});
}

class OrganizationStructureScreen extends StatefulWidget {
  const OrganizationStructureScreen({super.key});

  @override
  OrganizationStructurePageState createState() =>
      OrganizationStructurePageState();
}

class OrganizationStructurePageState
    extends State<OrganizationStructureScreen> {
  late final TreeController<Department> treeController;
  late final List<Department> departments;

  @override
  void initState() {
    super.initState();
    departments = _createDummyData();
    treeController = TreeController<Department>(
      roots: departments,
      childrenProvider: (Department department) => department.children,
    );
  }

  @override
  void dispose() {
    treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TreeView<Department>(
      treeController: treeController,
      nodeBuilder: (BuildContext context, TreeEntry<Department> entry) {
        return InkWell(
          onTap: () => _showEmployees(context, entry.node),
          child: TreeIndentation(
            entry: entry,
            child: Row(
              children: [
                Icon(
                  entry.hasChildren
                      ? (entry.isExpanded ? Icons.folder_open : Icons.folder)
                      : Icons.insert_drive_file,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.node.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          entry.node.type,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                if (entry.hasChildren)
                  IconButton(
                    icon: Icon(entry.isExpanded
                        ? Icons.expand_less
                        : Icons.expand_more),
                    onPressed: () => treeController.toggleExpansion(entry.node),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEmployees(BuildContext context, Department department) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${department.name} Employees'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: department.employees.map((employee) {
              return ListTile(
                title: Text(employee.name),
                subtitle: Text(employee.position),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  List<Department> _createDummyData() {
    final company = Department(
      id: 'D001',
      name: 'Team Sphere',
      code: 'CMP',
      level: 1,
      managerId: 'E001',
      description: 'C Level',
      type: 'Company',
      employees: [
        Employee(id: 'E001', name: 'John Doe', position: 'CEO'),
      ],
    );

    final finance = Department(
      id: 'D002',
      name: 'Finance',
      code: 'DIR',
      level: 2,
      parentId: 'D001',
      managerId: 'E002',
      description: 'Directorate',
      type: 'Directorate',
      employees: [
        Employee(id: 'E002', name: 'Jane Smith', position: 'CFO'),
      ],
    );

    final accounting = Department(
      id: 'D003',
      name: 'Accounting',
      code: 'DEP',
      level: 3,
      parentId: 'D002',
      managerId: 'E003',
      description: 'Department',
      type: 'Department',
      employees: [
        Employee(
            id: 'E003', name: 'Bob Johnson', position: 'Head of Accounting'),
      ],
    );

    final payroll = Department(
      id: 'D004',
      name: 'Payroll',
      code: 'DIV',
      level: 4,
      parentId: 'D003',
      managerId: 'E004',
      description: 'Division',
      type: 'Division',
      employees: [
        Employee(id: 'E004', name: 'Alice Brown', position: 'Payroll Manager'),
      ],
    );

    final payrollProcessing = Department(
      id: 'D005',
      name: 'Payroll Processing',
      code: 'UNT',
      level: 5,
      parentId: 'D004',
      managerId: 'E005',
      description: 'Unit',
      type: 'Unit',
      employees: [
        Employee(
            id: 'E005', name: 'Charlie Green', position: 'Payroll Specialist'),
      ],
    );

    return [
      company.copyWith(children: [
        finance.copyWith(children: [
          accounting.copyWith(children: [
            payroll.copyWith(children: [payrollProcessing])
          ])
        ])
      ])
    ];
  }
}
