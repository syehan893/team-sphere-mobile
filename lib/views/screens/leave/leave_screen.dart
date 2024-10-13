import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  LeaveScreenState createState() => LeaveScreenState();
}

class LeaveScreenState extends State<LeaveScreen> {
  bool showPendingRequests = false;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Leave',
      useBackButton: true,
      onBackTap: () {
        context.go('/home');
      },
      floatingActionButton: Button(
        title: 'Request Leave',
        onTap: () {
          context.go('/leave/request');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildLeaveCircle(),
            const SizedBox(height: 20),
            _buildLegend(),
            const SizedBox(height: 20),
            _buildTabBar(),
            const SizedBox(height: 20),
            Expanded(
              child: showPendingRequests
                  ? _buildPendingRequestList()
                  : _buildMyLeavesList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => showPendingRequests = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !showPendingRequests
                      ? Colors.indigo[800]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'My Leave(s)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          !showPendingRequests ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => showPendingRequests = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: showPendingRequests
                      ? Colors.indigo[800]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'Pending Request',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: showPendingRequests ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyLeavesList() {
    return ListView(
      children: [
        _buildLeaveCard('Annual', '29 Jul - 31 Aug', LeaveStatus.approved),
        _buildLeaveCard('Special', '29 Jul - 31 Aug', LeaveStatus.pending),
        _buildLeaveCard('Sick', '29 Jul - 31 Aug', LeaveStatus.declined),
        _buildLeaveCard('Annual', '29 Jul - 31 Aug', LeaveStatus.approved),
        _buildLeaveCard('Annual', '29 Jul - 31 Aug', LeaveStatus.approved),
      ],
    );
  }

  Widget _buildPendingRequestList() {
    return ListView(
      children: [
        _buildPendingRequestCard('Muhammad Syehan', 'MS', '29 Jul - 31 Aug'),
        _buildPendingRequestCard('Muhammad Fernando', 'MF', '02 Jun - 07 Jun'),
        _buildPendingRequestCard('Agatha Aurel', 'AA', '16 Dec - 27 Dec'),
      ],
    );
  }

  Widget _buildPendingRequestCard(String name, String initials, String date) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.amber[100],
              child: Text(initials, style: TextStyle(color: Colors.amber[800])),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(date, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveCircle() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue[100],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(Colors.blue, 'Annual'),
        const SizedBox(width: 20),
        _buildLegendItem(Colors.red, 'Sick'),
        const SizedBox(width: 20),
        _buildLegendItem(Colors.green, 'Special'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }

  Widget _buildLeaveCard(String type, String date, LeaveStatus status) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            _buildStatusChip(status),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(LeaveStatus status) {
    Color color;
    String label;

    switch (status) {
      case LeaveStatus.approved:
        color = Colors.green;
        label = 'Approved';
        break;
      case LeaveStatus.pending:
        color = Colors.orange;
        label = 'Pending';
        break;
      case LeaveStatus.declined:
        color = Colors.red;
        label = 'Declined';
        break;
      default:
        color = Colors.indigo[800]!;
        label = 'Request Leave';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

enum LeaveStatus { approved, pending, declined }
