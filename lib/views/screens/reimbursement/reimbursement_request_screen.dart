import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class ReimbursementRequestScreen extends StatefulWidget {
  const ReimbursementRequestScreen({super.key});

  @override
  ReimbursementRequestScreenState createState() => ReimbursementRequestScreenState();
}

class ReimbursementRequestScreenState extends State<ReimbursementRequestScreen> {
  final _titleController = TextEditingController();
  DateTime _invoiceDate = DateTime.now();
  String _reimbursementType = 'Software';
  String? _fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reimburse'),
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
              'Submit your reimburse',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _buildDatePicker(),
            const SizedBox(height: 16),
            _buildDropdown(),
            const SizedBox(height: 16),
            _buildFileUpload(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F51B5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _submitReimbursementRequest,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _invoiceDate,
          firstDate: DateTime(2024),
          lastDate: DateTime(2025),
        );
        if (picked != null) {
          setState(() => _invoiceDate = picked);
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Invoice Date',
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('dd/MM/yyyy').format(_invoiceDate)),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Reimbursement Type',
        border: OutlineInputBorder(),
      ),
      value: _reimbursementType,
      onChanged: (String? newValue) {
        setState(() {
          _reimbursementType = newValue!;
        });
      },
      items: <String>['Software', 'Hardware', 'Travel', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildFileUpload() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(_fileName ?? 'No file selected'),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.cloud_upload),
            label: const Text('Upload'),
            onPressed: _pickFile,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3F51B5),
            ),
          ),
        ],
      ),
    );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }

  void _submitReimbursementRequest() {
    // print('Reimbursement request submitted');
    // print('Title: ${_titleController.text}');
    // print('Invoice Date: $_invoiceDate');
    // print('Reimbursement Type: $_reimbursementType');
    // print('File: $_fileName');
  }
}