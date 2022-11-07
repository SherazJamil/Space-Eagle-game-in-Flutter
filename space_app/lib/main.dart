import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_app/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.indigo,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Space Eagle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}