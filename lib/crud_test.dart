import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreExample extends StatefulWidget {
  @override
  _FirestoreExampleState createState() => _FirestoreExampleState();
}

class _FirestoreExampleState extends State<FirestoreExample> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? _title;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Enter title',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Enter description',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _createData(
                    _titleController.text, _descriptionController.text);
                _titleController.clear();
                _descriptionController.clear();
              },
              child: Text('Create'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _readData();
              },
              child: Text('Read'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _updateData(
                    _titleController.text, _descriptionController.text);
                _titleController.clear();
                _descriptionController.clear();
              },
              child: Text('Update'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _deleteData();
              },
              child: Text('Delete'),
            ),
            SizedBox(height: 20),
            Text(_title ?? ''),
            Text(_description ?? ''),
          ],
        ),
      ),
    );
  }

  Future<void> _createData(String title, String description) async {
    await firestore
        .collection('newUsers')
        .add({'title': title, 'description': description});
  }

  Future<void> _readData() async {
    final DocumentSnapshot snapshot =
        await firestore.collection('newUsers').doc('your_doc_id').get();
    setState(() {
      _title = snapshot['title'];
      _description = snapshot['description'];
    });
  }

  Future<void> _updateData(String title, String description) async {
    await firestore
        .collection('newUsers')
        .doc('your_doc_id')
        .update({'title': title, 'description': description});
  }

  Future<void> _deleteData() async {
    await firestore.collection('newUsers').doc('your_doc_id').delete();
  }
}
