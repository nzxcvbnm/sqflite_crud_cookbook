import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: <Widget>[
          HomeScreen(),
        ],
      ),
    );
  }
}

background() => Opacity(
      opacity: 0.1,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/cupcake.png'),
                repeat: ImageRepeat.repeat)),
      ),
    );
