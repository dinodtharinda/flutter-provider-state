import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_demo/bread_crumb_app/bread_crumb_screen.dart';
import 'package:provider_state_demo/details_of_provider/details_of_provider.dart';

////====bread crumb app====
// void main() {
//   runApp(ChangeNotifierProvider(
//     create: (_) => BreadCrumbProvider(),
//     child: const MaterialApp(
//       home: BreadCrumbScreen(),
//     ),
//   ));
// }


//details of provider course
void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ObjectProvider(),
    child: const MaterialApp(
      home: DetailsOfProviderScreen(),
    ),
  ));
}

