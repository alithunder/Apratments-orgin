import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api_service.dart'; // Ensure this import points to where your ApiService class is located.

class AddUsersPage extends StatefulWidget {
  @override
  _AddUsersPageState createState() => _AddUsersPageState();
}

class _AddUsersPageState extends State<AddUsersPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _email = '';
  String _phone = '';
  String _role = 'user'; // Assuming 'user' as default role, adjust as needed
  List<String> roles = ['user', 'admin']; // Define roles if you want to select from UI
  String? _selectedBuilding;
  String? _selectedUnit;
  String? _selectedApartment;
  List<String> buildings = ['A', 'B', 'C']; // Example buildings, adjust as needed
  List<String> units = ['1', '2', '3']; // Example units for each building, adjust as needed
  List<String> apartments = List.generate(100, (index) => (index + 1).toString()); // Example apartments

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Since addUser is a void function, we just await its completion.
        // Success or failure will now be handled through exceptions.
        await ApiService().addUser(
          username: _username,
          password: _password,
          email: _email,
          phone: _phone,
          role: _role,
          building: _selectedBuilding ?? '',
          unit: _selectedUnit ?? '',
          apartment: _selectedApartment ?? '',
        );
        // If addUser completes without throwing an exception, assume success.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User added successfully')),
        );
      } catch (e) {
        // Catch exceptions thrown by addUser to handle errors.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User', style: GoogleFonts.almarai()),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTextField(
                hintText: 'Username',
                onChanged: (value) => _username = value,
              ),
              _buildTextField(
                hintText: 'Password',
                isPassword: true,
                onChanged: (value) => _password = value,
              ),
              _buildTextField(
                hintText: 'Email',
                onChanged: (value) => _email = value,
              ),
              _buildTextField(
                hintText: 'Phone',
                onChanged: (value) => _phone = value,
              ),
              _buildDropdownButtonFormField(
                hintText: 'Role',
                value: _role,
                items: roles,
                onChanged: (value) => setState(() => _role = value!),
              ),
              _buildDropdownButtonFormField(
                hintText: 'Building',
                value: _selectedBuilding,
                items: buildings,
                onChanged: (value) => setState(() => _selectedBuilding = value),
              ),
              _buildDropdownButtonFormField(
                hintText: 'Unit',
                value: _selectedUnit,
                items: units,
                onChanged: (value) => setState(() => _selectedUnit = value),
              ),
              _buildDropdownButtonFormField(
                hintText: 'Apartment',
                value: _selectedApartment,
                items: apartments,
                onChanged: (value) => setState(() => _selectedApartment = value),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add User', style: GoogleFonts.almarai()),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hintText, required Function(String) onChanged, bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.almarai(),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25.7),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          prefixIcon: isPassword ? Icon(Icons.lock) : Icon(Icons.person),
        ),
        obscureText: isPassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          return null;
        },
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdownButtonFormField({
    required String hintText,
    required List<String> items,
    String? value,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.almarai(),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25.7),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        ),
        value: value,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: GoogleFonts.almarai()),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
