import 'package:flutter/material.dart';
import 'detail.dart';
import 'read.dart';
import 'main.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Center(
            child: Text(
          'Your delicious recipes',
        )),
      ),
      body: Stack(
        children: <Widget>[
          background(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Add recipe of your dish',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CreateButton(),
                ),
                Text(
                  'Show list of your recipes',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReadButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _navigateToCreateScreen(context);
        },
        child: IconButton(
            icon: Icon(Icons.border_color, color: Colors.pinkAccent, size: 30,)));
  }

  _navigateToCreateScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen()),
    );
    Scaffold.of(context)..removeCurrentSnackBar();
  }
}

class ReadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _navigateToReadScreen(context);
        },
        child: IconButton(
            icon: Icon(Icons.apps, color: Colors.pinkAccent, size: 38)));
  }

  _navigateToReadScreen(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReadScreen()),
    );
  }
}
