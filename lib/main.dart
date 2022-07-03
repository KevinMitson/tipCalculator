import 'package:flutter/material.dart';
import 'package:tipcalc/screens/billsplinter.dart';
import 'package:tipcalc/screens/home.dart';

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
      title: 'Tip Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BillSplinter(),
    );
  }
}
