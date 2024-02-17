import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'finalpage.dart';
class ProblemsPage extends StatefulWidget {
  @override
  _ProblemsPageState createState() => _ProblemsPageState();
}

class _ProblemsPageState extends State<ProblemsPage> {
  final List<Map<String, dynamic>> problems = [
    {
      "title": "انقطاع الكهرباء",
      "image": "assets/background.jpg", // Placeholder image path
      "isChecked": false,
    },
    {
      "title": "انقطاع الماء",
      "image": "assets/wateroff.jpg", // Placeholder image path
      "isChecked": false,
    },
    {
      "title": "عطل المصعد",
      "image": "assets/elevator.jpg", // Placeholder image path
      "isChecked": false,
    },
    {
      "title": "عمال النظافة",
      "image": "assets/cleaners.jpg", // Placeholder image path
      "isChecked": false,
    },
    {
      "title": "ميزانية الكهرباء",
      "image": "assets/miz.jpg", // Placeholder image path
      "isChecked": false,
    },
    {
      "title": "عطل احد اجهزة المنزل",
      "image": "assets/homeelec.jpg", // Placeholder image path
      "isChecked": false,
    },
  ];

  void _navigateToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LastPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المشاكل', style: GoogleFonts.almarai()),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: problems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      // Checkbox
                      Checkbox(
                        value: problems[index]["isChecked"],
                        onChanged: (bool? value) {
                          setState(() {
                            problems[index]["isChecked"] = value!;
                          });
                        },
                      ),
                      // Image
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(problems[index]["image"], fit: BoxFit.cover),
                      ),
                      // Expanded to fill the available space
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            problems[index]["title"],
                            style: GoogleFonts.almarai(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _navigateToNextPage(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFF6D61F2), // Text
                minimumSize: Size(double.infinity, 50), // set the size
                // style here
              ),
              child: Text(
                'تثبيت',
                style: GoogleFonts.almarai(
                  fontSize: 21,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
