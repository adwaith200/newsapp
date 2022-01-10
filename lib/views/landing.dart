import 'package:flutter/material.dart';


class Landing extends StatefulWidget {
  const Landing({ Key? key }) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
 @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds:3),(){
      Navigator.pushNamed(context, '/home');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child:Container(
        color:Colors.red[900],
        child:Center(
          child: Image(
            width:50,
            height:50,
            image:AssetImage(
              'assets/landing_news_img.png'
              ),
            ),
        )
        )
      );
    
  }
}