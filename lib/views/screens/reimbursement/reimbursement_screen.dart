
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_sphere_mobile/views/widgets/widgets.dart';

class ReimbursementScreen extends StatefulWidget {
  const ReimbursementScreen({super.key});

  @override
  ReimbursementPageState createState() => ReimbursementPageState();
}

class ReimbursementPageState extends State<ReimbursementScreen> {
  bool showPendingRequests = false;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Reimburse',
      useBackButton: true,
      onBackTap: () => context.go('/home'),
       floatingActionButton: Button(
        title: 'Request Reimburse',
        onTap: () {
          context.go('/reimburse/request');
        },
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: showPendingRequests
                ? _buildPendingRequestList()
                : _buildMyReimbursementList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(16),
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
                  color: !showPendingRequests ? Colors.indigo[800] : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'My Reimburse(s)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: !showPendingRequests ? Colors.white : Colors.black),
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
                  color: showPendingRequests ? Colors.indigo[800] : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'Pending Request',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: showPendingRequests ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyReimbursementList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildReimbursementCard('Adobe Photoshop', '29 May 2024', 2000000, Colors.green),
        _buildReimbursementCard('Pizza Hut', '29 May 2024', 140000, Colors.red),
        _buildReimbursementCard('Internet Bulan Agustus', '29 May 2024', 350000, Colors.orange),
        _buildReimbursementCard('Bayar Server', '29 May 2024', 113000000, Colors.green),
        _buildReimbursementCard('Gojeck ke kantor', '29 May 2024', 12000, Colors.green),
      ],
    );
  }

  Widget _buildPendingRequestList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildPendingRequestCard('Muhammad Fernando', 'MF', 'Subcribe chatgpt', 350000, '29 May 2024'),
        _buildPendingRequestCard('Muhammad Syehan', 'MS', 'Bayar domain', 1000000, '29 May 2024'),
        _buildPendingRequestCard('Michel Jackson', 'MJ', 'Makan 17 Agustusan', 350000, '29 May 2024'),
      ],
    );
  }

  Widget _buildReimbursementCard(String title, String date, int amount, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              color: color,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Rp. ${amount.toString()}', style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Text(date, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingRequestCard(String name, String initials, String description, int amount, String date) {
    return GestureDetector(
      onTap: () => _showDetailModal(context, name, description, amount, date),
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.amber[50],
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
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('$description - Rp. ${amount.toString()}', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Text(date, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetailModal(BuildContext context, String name, String description, int amount, String date) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.7,
        maxChildSize: 0.75,
        expand: false,
        builder: (_, controller) => SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(description, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Rp. ${amount.toString()}', style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                const SizedBox(height: 10),
                Chip(label: const Text('Software'), backgroundColor: Colors.blue[100]),
                const SizedBox(height: 20),
                _buildDetailItem('ID', '244'),
                _buildDetailItem('Invoice Date', '27 May 2024'),
                _buildDetailItem('Submitted Date', '29 May 2024'),
                const SizedBox(height: 20),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text('Reject'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text('Approve'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}