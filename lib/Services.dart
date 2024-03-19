import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'finalpage.dart';
import 'api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProblemsPage extends StatefulWidget {
  @override
  _ProblemsPageState createState() => _ProblemsPageState();
}

class _ProblemsPageState extends State<ProblemsPage> {
  late List<Map<String, dynamic>> problems;
  final ApiService _apiService = ApiService();

  @override
  @override
  void initState() {
    super.initState();
    problems =  [
      {
        "title": "انقطاع الكهرباء",
        "image": "assets/electricity_outage.jpg",
        "isChecked": false,
        "controller": TextEditingController(),
      },
      {
        "title": "انقطاع الماء",
        "image": "assets/water_outage.jpg",
        "isChecked": false,
        "controller": TextEditingController(),
      },
      {
        "title": "عطل المصعد",
        "image": "assets/elevator_malfunction.jpg",
        "isChecked": false,
        "controller": TextEditingController(),
      },
      {
        "title": "عمال النظافة",
        "image": "assets/cleaning_services.jpg",
        "isChecked": false,
        "controller": TextEditingController(),
      },
      {
        "title": "ميزانية الكهرباء",
        "image": "assets/electrical_issues.jpg",
        "isChecked": false,
        "controller": TextEditingController(),
      },
      {
        "title": "عطل احد اجهزة المنزل",
        "image": "assets/appliance_malfunction.jpg",
        "isChecked": false,
        "controller": TextEditingController(),
      },
      {
        "title": "مشاكل الصرف الصحي",
        "image": "assets/plumbing_issues.jpg",
        "isChecked": false,
        "controller": TextEditingController(),
      },
      {
        "title": "تسرب المياه",
        "image": "assets/water_leak.jpg",
        "isChecked": false,
        "controller": TextEditingController(),
      },
      {
        "title": "مشاكل التدفئة والتبريد",
        "image": "assets/heating_cooling_issues.jpg",
        "isChecked": false,
        "controller": TextEditingController(),
      },
      {
        "title": "إنارة المناطق العامة",
        "image": "assets/public_lighting_issues.jpg",
        "isChecked": false,
        "controller": TextEditingController(),
      },
    ];
  }


  @override
  void dispose() {
    for (var problem in problems) {
      problem['controller'].dispose();
    }
    super.dispose();
  }

  Future<void> _submitProblems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userId = prefs.getInt('userId') ?? 0; // Use a safe default or handle null appropriately

    // Assuming "success" is declared outside the loop for simplicity in this context
    bool success = true;

    for (var problem in problems.where((p) => p['isChecked'])) {
      var title = problem['title'];
      var description = problem['controller'].text;

      success = await _apiService.submitProblem(
        title: title,
        description: description,
        userId: userId,
      );

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit "$title". Please try again.')),
        );
        // Optionally, break out of the loop if one submission fails
        break;
      }
    }

    // If all submissions are successful, proceed
    if (success) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LastPage()));
    }
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
                var problem = problems[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Checkbox(
                          value: problem["isChecked"],
                          onChanged: (bool? value) {
                            setState(() {
                              problem["isChecked"] = value!;
                            });
                          },
                        ),
                        title: Text(problem["title"], style: GoogleFonts.almarai()),
                        subtitle: problem["isChecked"]
                            ? TextField(
                          controller: problem["controller"],
                          decoration: InputDecoration(
                            hintText: "Add a description",
                          ),
                        )
                            : null,
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
              onPressed: _submitProblems,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF6D61F2),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('تثبيت', style: GoogleFonts.almarai(fontSize: 21)),
            ),
          ),
        ],
      ),
    );
  }
}
