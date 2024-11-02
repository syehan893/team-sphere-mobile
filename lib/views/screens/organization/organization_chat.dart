import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/views/screens/organization/dummy_data.dart';


// Widget untuk menampilkan data OrganizationLevel dalam bentuk TreeView
class OrganizationTreeView extends StatelessWidget {
  final OrganizationLevel organization;

  const OrganizationTreeView({super.key, required this.organization});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(organization.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildOrganizationTree(organization),
        ),
      ),
    );
  }

  // Fungsi untuk membangun pohon organisasi menggunakan ExpansionTile
  Widget _buildOrganizationTree(OrganizationLevel level) {
    return ExpansionTile(
      title: Text(level.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: [
        // Menambahkan employees di level ini
        for (var employee in level.employees)
          ListTile(
            title: Text(employee.name),
            subtitle: Text(employee.position),
            leading: const Icon(Icons.person),
          ),

        // Menambahkan children (sub-levels) di level ini
        for (var child in level.children) _buildOrganizationTree(child),
      ],
    );
  }
}
