import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class ViewUsersPage extends StatefulWidget {
  @override
  _ViewUsersPageState createState() => _ViewUsersPageState();
}

class _ViewUsersPageState extends State<ViewUsersPage> {
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/viewUsers'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<User> userList = jsonResponse.map((user) => User.fromJson(user)).toList();
      return userList;
    } else {
      throw Exception('Failed to load users from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Users'),
      ),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            List<User>? userList = snapshot.data;
            if(userList!.isEmpty) {
              return Center(child: Text('No users found'));
            }
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                User user = userList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(user.username),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text('Email: ${user.email}'),
                          Text('Phone: ${user.phone}'),
                          Text('Role: ${user.role}'),
                          Text('Building: ${user.building}'),
                          Text('Unit: ${user.unit}'),
                          Text('Apartment: ${user.apartment}'),
                          Text('Created at: ${user.createdAt}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No users found'));
          }
        },
      ),
    );
  }
}
