import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'Services.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  String? selectedBuilding;
  String? selectedUnit;
  String? selectedApartment;
  List<String> units = [];
  final List<String> apartments = List.generate(100, (index) => (index + 1).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                'أملأ المعلومات',
                style: GoogleFonts.almarai(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              _buildTextField(
                hintText: 'الاسم',
                onChanged: (value) => name = value,
              ),
              _buildTextField(
                hintText: 'العنوان',
                onChanged: (value) => address = value,
              ),
              _buildDropdownButtonFormField(
                hintText: 'البلوك',
                value: selectedBuilding,
                items: ['A', 'B', 'C'],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBuilding = newValue;
                    selectedUnit = null; // Reset unit selection
                    units = List.generate(8, (index) => "${newValue!}${index + 1}");
                  });
                },
              ),
              if (selectedBuilding != null) ...[
                _buildDropdownButtonFormField(
                  hintText: 'البناية',
                  value: selectedUnit,
                  items: units,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedUnit = newValue;
                    });
                  },
                ),
              ],
              _buildDropdownButtonFormField(
                hintText: 'الشقة',
                value: selectedApartment,
                items: apartments,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedApartment = newValue;
                  });
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Get.to(ProblemsPage());
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFF6D61F2), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  'تسجيل',
                  style: GoogleFonts.almarai(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hintText, required Function(String) onChanged}) {
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
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال $hintText';
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
          fillColor: Colors.grey[199],
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
