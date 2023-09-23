//dive into meals, mark them as favourite and also see them under favourites tab
//filter the meal once we oick the category.
//learned about navigation in multi screen app.
//learned about how to add tabs with bottomNavigatorBar.
//learned how to add a side drawer.
//also learned how to have full control over process of going back to dirrerent screens.
//learned how to return data while poping the screen.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(
    ThemeData.dark().textTheme,
  ),
);

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
