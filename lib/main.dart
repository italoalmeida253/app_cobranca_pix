import 'package:app_cobranca_pix/constants/index.dart';
import 'package:app_cobranca_pix/screens/home_screen.dart';
import 'package:app_cobranca_pix/services/isar.dart';
import 'package:app_cobranca_pix/theme/colors.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDatabase.initialize();
  await AppTrackingTransparency.requestTrackingAuthorization();
  prefs = await SharedPreferences.getInstance();
  debugRepaintRainbowEnabled = true;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool? darkModePref = prefs.getBool(UserPrefs.darkModeKey.toString());
  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;
  late bool lightTheme;

  @override
  initState() {
    super.initState();
    if (darkModePref != null) {
      _themeMode = darkModePref! ? ThemeMode.dark : ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
  }

  changeThemeMode(ThemeMode themeMode) async {
    if (themeMode == ThemeMode.dark) {
      await prefs.setBool(UserPrefs.darkModeKey.toString(), true);
    } else {
      await prefs.setBool(UserPrefs.darkModeKey.toString(), false);
    }
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    lightTheme = _themeMode == ThemeMode.system
        ? MediaQuery.of(context).platformBrightness == Brightness.light
        : _themeMode == ThemeMode.light;

    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(color: secondaryColor),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
          iconTheme: const IconThemeData(color: Colors.black),
          colorScheme: ColorScheme.fromSeed(
              seedColor: terciaryColor,
              background: primaryColor,
              inverseSurface: Colors.black,
              surface: Colors.white),
          useMaterial3: true,
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: terciaryColor, selectionHandleColor: terciaryColor),
          textTheme: TextTheme(
              displaySmall: GoogleFonts.sora(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
              displayMedium: GoogleFonts.sora(
                  textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
              displayLarge: GoogleFonts.sora(
                  textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
              bodySmall: GoogleFonts.sora(
                  textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              )),
              bodyMedium: GoogleFonts.sora(
                  textStyle: const TextStyle(
                fontSize: 16,
              )))),
      darkTheme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor))),
          iconTheme: const IconThemeData(color: Colors.white),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              background: const Color(0xFF131313),
              inverseSurface: Colors.white,
              surface: const Color(0xFF1F1F1F),
              primary: darkPrimaryColor),
          useMaterial3: true,
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: primaryColor, selectionHandleColor: primaryColor),
          textTheme: TextTheme(
              displaySmall: GoogleFonts.sora(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
              displayMedium: GoogleFonts.sora(
                  textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
              displayLarge: GoogleFonts.sora(
                  textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
              bodySmall: GoogleFonts.sora(
                  textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              )),
              bodyMedium: GoogleFonts.sora(
                  textStyle:
                      const TextStyle(fontSize: 16, color: Colors.white)))),
      home: const HomeScreen(),
    );
  }
}
