import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:language_translator/language_translation.dart';
// import 'package:language_translator/onboarding_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('favorites');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Language Translator Application",
      debugShowCheckedModeBanner: false,
      home: LanguageTranslationPage(),
    );
  }
}