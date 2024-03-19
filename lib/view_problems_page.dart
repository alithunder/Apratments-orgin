import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'problem_detail_page.dart'; // Make sure this import is correct

class ViewProblemsPage extends StatefulWidget {
  @override
  _ViewProblemsPageState createState() => _ViewProblemsPageState();
}

class _ViewProblemsPageState extends State<ViewProblemsPage> {
  Future<List<Problem>> fetchProblems() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/viewProblems'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Problem.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load problems from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Problems'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<Problem>>(
        future: fetchProblems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Problem problem = snapshot.data![index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(Icons.report_problem, color: Colors.deepPurple),
                    title: Text(problem.title, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(problem.description),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProblemDetailPage(
                          title: problem.title,
                          description: problem.description,
                          status: problem.status,
                          reportedAt: problem.reportedAt,
                          userName: problem.userName,
                          userEmail: problem.userEmail,
                          userPhone: problem.userPhone,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No problems found'));
          }
        },
      ),
    );
  }
}

class Problem {
  final int id;
  final String title;
  final String description;
  final String status;
  final String reportedAt;
  final String userName;
  final String userEmail;
  final String userPhone;

  Problem({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.reportedAt,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
  });

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      reportedAt: json['reported_at'],
      userName: json['reportedBy'], // Adjust according to actual API response
      userEmail: json['email'], // Adjust according to actual API response
      userPhone: json['phone'], // Adjust according to actual API response
    );
  }
}

