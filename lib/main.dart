import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'login.dart';
import 'signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "assets/background.jpg",
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.3), // Add a dark overlay on the background
            ),
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.1), // Optional: Adjust the overlay color and opacity
              ),
            ),
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'مجمع النهرين السكني',
                      style: GoogleFonts.almarai(
                        fontSize: 26, // Slightly larger for prominence
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5, // Adjust letter spacing for cleanliness
                      ),
                    ),
                    SizedBox(height: 10), // Add space between the texts
                    Text(
                      'تطبيق يخدم سكان المجمع',
                      style: GoogleFonts.almarai(
                        fontSize: 18,
                        color: Colors.white70,
                        letterSpacing: 0.2, // Subtle letter spacing for a cleaner look
                      ),
                    ),
                    // Inside your MyApp class or wherever you're building your UI
                  SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(SignInPage());
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF007EF4), Color(0xFF2A75BC)], // Gradient colors
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0), // Rounded corners
                        ),
                        child: Container(
                          constraints: BoxConstraints(minWidth: 200.0, minHeight: 50.0), // Button size
                          alignment: Alignment.center,
                          child: Text(
                            'Go to Next Page',
                            style: GoogleFonts.almarai(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.all(0), // Remove padding because we're using Ink
                        backgroundColor: Colors.transparent, // Make button background transparent
                        shadowColor: Colors.black.withOpacity(0.5), // Shadow color
                        elevation: 5, // Shadow elevation
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
