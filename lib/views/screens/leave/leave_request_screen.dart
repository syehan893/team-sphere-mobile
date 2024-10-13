import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  LeaveRequestScreenState createState() => LeaveRequestScreenState();
}

class LeaveRequestScreenState extends State<LeaveRequestScreen> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String leaveType = 'Annual';
  TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Submit your leave',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildDatePicker('Start Date', startDate, (newDate) {
              setState(() => startDate = newDate);
            }),
            const SizedBox(height: 16),
            _buildDatePicker('End Date', endDate, (newDate) {
              setState(() => endDate = newDate);
            }),
            const SizedBox(height: 16),
            _buildDropdown(),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F51B5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _submitLeaveRequest,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(
      String label, DateTime date, Function(DateTime) onDateChanged) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2024),
          lastDate: DateTime(2025),
        );
        if (picked != null) onDateChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('dd/MM/yyyy').format(date)),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Leave Type',
        border: OutlineInputBorder(),
      ),
      value: leaveType,
      onChanged: (String? newValue) {
        setState(() {
          leaveType = newValue!;
        });
      },
      items: <String>['Annual', 'Sick', 'Personal']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _submitLeaveRequest() {
    // print('Leave request submitted');
    // print('Start Date: $startDate');
    // print('End Date: $endDate');
    // print('Leave Type: $leaveType');
    // print('Reason: ${reasonController.text}');
  }
}
