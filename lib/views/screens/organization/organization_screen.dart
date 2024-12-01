import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

import '../../../data/data.dart';
import '../../cubits/organization_cubit.dart';

class OrganizationStructureScreen extends StatefulWidget {
  const OrganizationStructureScreen({super.key});

  @override
  OrganizationStructurePageState createState() =>
      OrganizationStructurePageState();
}

class OrganizationStructurePageState
    extends State<OrganizationStructureScreen> {
  late final TreeController<Organization> treeController;

  @override
  void initState() {
    super.initState();
    context.read<DepartmentCubit>().getDepartments();
  }

  @override
  void dispose() {
    treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepartmentCubit, DepartmentState>(
      builder: (context, state) {
        if (state.status == FetchStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == FetchStatus.error) {
          return Center(
            child: Text(
              state.errorMessage ?? 'Failed to load departments.',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        if (state.status == FetchStatus.loaded) {
          treeController = TreeController<Organization>(
            roots: state.departments ?? [],
            childrenProvider: (Organization department) => department.children,
          );

          return TreeView<Organization>(
            treeController: treeController,
            nodeBuilder: (BuildContext context, TreeEntry<Organization> entry) {
              return InkWell(
                onTap: () => treeController.toggleExpansion(entry.node),
                child: TreeIndentation(
                  entry: entry,
                  child: Row(
                    children: [
                      Icon(
                        entry.hasChildren
                            ? (entry.isExpanded
                                ? Icons.corporate_fare_rounded
                                : Icons.corporate_fare_rounded)
                            : Icons.corporate_fare_rounded,
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
                                entry.node.departmentName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                entry.node.type,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
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
                          onPressed: () =>
                              treeController.toggleExpansion(entry.node),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(
            child: Body1.regular(
          'No Data',
          fontSize: 14,
        ));
      },
    );
  }
}
