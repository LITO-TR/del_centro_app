import 'package:del_centro_app/layouts/layout.dart';
import 'package:del_centro_app/styles/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'Inter',
          scaffoldBackgroundColor: Styles.scaffoldBackgroundColor),
      home: const Layout(),
    );
  }
}
