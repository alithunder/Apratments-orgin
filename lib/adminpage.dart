import 'package:flutter/material.dart';
import 'add_users_page.dart';
import 'view_users_page.dart';
import 'view_problems_page.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    AddUsersPage(),
    ViewUsersPage(),
    ViewProblemsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'View Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_problem),
            label: 'View Problems',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
