import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_demo/bread_crumb_app/bread_crumb_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => BreadCrumbProvider(),
    child: const MaterialApp(
      home: BreadCrumbScreen(),
    ),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ), 
    );
  }
}
