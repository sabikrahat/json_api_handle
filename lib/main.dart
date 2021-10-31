import 'package:flutter/material.dart';
import 'package:json_api_handle/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rest Api',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange[100],
          elevation: 0.0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
