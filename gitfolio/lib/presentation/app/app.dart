import 'package:flutter/material.dart';
import 'package:gitfolio/presentation/pages/preview/preview_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const PreviewPage(),
    );
  }
}