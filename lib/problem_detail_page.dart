import 'package:flutter/material.dart';

class ProblemDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final String reportedAt;
  final String userName;
  final String userEmail;
  final String userPhone;

  const ProblemDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.status,
    required this.reportedAt,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description: $description',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 10),
            Text(
              'Status: $status',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 10),
            Text(
              'Reported At: $reportedAt',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 10),
            Text(
              'Reported By: $userName',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 10),
            Text(
              'Email: $userEmail',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: $userPhone',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
