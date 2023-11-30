import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models%20&%20providers/todos.dart';
import 'package:todo_app/screens/HomeScreen.dart';

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
    return ChangeNotifierProvider(
      create: (context) => Todos(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(48, 49, 52, 1),
          textTheme: TextTheme(
              bodyLarge: TextStyle(
                  fontFamily: "Satisfy",
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  color: Colors.white),
              bodyMedium: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                  color: Colors.white)),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.black),
        ),
        routes: {
          '/': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
