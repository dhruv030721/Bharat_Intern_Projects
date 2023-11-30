import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/pages/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        primaryColor: Colors.grey[900],
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.poppins(
              color: Colors.white, fontSize: size.height * 0.03),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
