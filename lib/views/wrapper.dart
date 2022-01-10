import 'package:flutter/material.dart';
import 'package:news_app/models/user.dart';
import 'package:news_app/views/authenticate.dart';
import 'package:news_app/views/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
