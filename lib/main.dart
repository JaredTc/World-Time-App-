import 'package:flutter/material.dart';
import 'package:world_time_app/providers/time_provider.dart';
import 'package:world_time_app/screens/list_time_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => TimeProvider())],
    child: const MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World Time App',
      home: ListTimeScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF2F2F6),
        fontFamily: 'sans-serif',
      ),
    );
  }
}
