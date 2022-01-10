import 'package:flutter/material.dart';
import 'package:news_app/helper/auth.dart';
import 'package:news_app/models/user.dart';
import 'package:news_app/views/wrapper.dart';
import './views/home.dart';
import './views/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
          title: "News App",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.black),
          home: Wrapper()),
    );
  }
}
