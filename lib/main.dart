import 'package:flutter/material.dart';
import 'package:isuna_owo/screen/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget App',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}
