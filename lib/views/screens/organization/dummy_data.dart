class Employee {
  final String name;
  final String position;

  Employee(this.name, this.position);
}

class OrganizationLevel {
  final String name;
  final List<OrganizationLevel> children;
  final List<Employee> employees;

  OrganizationLevel({
    required this.name,
    this.children = const [],
    this.employees = const [],
  });
}

// Data organisasi
final organization = OrganizationLevel(
  name: 'PT Cahaya Nusantara',
  children: [
    OrganizationLevel(
      name: 'Direktorat Teknologi Informasi',
      children: [
        OrganizationLevel(
          name: 'Departemen Pengembangan Aplikasi',
          children: [
            OrganizationLevel(
              name: 'Divisi Mobile',
              employees: [
                Employee('Andi Nugraha', 'Senior Mobile Developer'),
                Employee('Budi Setiawan', 'Junior Mobile Developer'),
              ],
            ),
            OrganizationLevel(
              name: 'Divisi Web',
              employees: [
                Employee('Andi Nugraha', 'Senior Mobile Developer'),
                Employee('Budi Setiawan', 'Junior Mobile Developer'),
              ],
            ),
          ],
        ),
        OrganizationLevel(
          name: 'Departemen Infrastruktur',
          children: [
            OrganizationLevel(
              name: 'Tim Jaringan',
              employees: [
                Employee('Andi Nugraha', 'Senior Mobile Developer'),
                Employee('Budi Setiawan', 'Junior Mobile Developer'),
              ],
            ),
          ],
        ),
      ],
    ),
    OrganizationLevel(
      name: 'Direktorat Pemasaran',
      children: [
        OrganizationLevel(
          name: 'Departemen Infrastruktur',
          children: [
            OrganizationLevel(
              name: 'Tim Jaringan',
              employees: [
                Employee('Andi Nugraha', 'Senior Mobile Developer'),
                Employee('Budi Setiawan', 'Junior Mobile Developer'),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);