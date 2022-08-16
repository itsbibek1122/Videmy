import 'package:chat_app/Authenticate/Authenticate.dart';
import 'package:chat_app/pdf/products_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {ProductsDetailsPage.id: (context) => ProductsDetailsPage()},
      home: Authenticate(),
    );
  }
}
