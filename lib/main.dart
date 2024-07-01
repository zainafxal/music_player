import 'package:flutter/material.dart';
import 'package:music_player/Models/playlist_provider.dart';
import 'package:music_player/Pages/home_page.dart';
import 'package:music_player/Theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(), // Initialize ThemeProvider
        ),
        ChangeNotifierProvider<PlaylistProvider>(
          create: (context) => PlaylistProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          theme: themeProvider.themeData,
        );
      },
    );
  }
}
