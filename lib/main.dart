import 'package:flutter/material.dart';
import 'package:notes/appearance/provider.dart';
import 'package:notes/notes_screen.dart';
import 'package:provider/provider.dart';
import 'assets/notes_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotesDB.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => NotesDB(),
      child: const MyApp(),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemeSet(),
      child: const MyApp(),
    )
  ]));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: notesScreen(),
    );
  }
}
