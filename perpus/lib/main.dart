import 'package:flutter/material.dart';
import 'package:perpus/models/perpus_model.dart';
import 'package:perpus/views/perpus_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PERPUSTAKAAN',
      initialRoute: '/Perpus',  
      routes: {
      '/Perpus': (context) => PerpusView(),
      },
    );
  }
}